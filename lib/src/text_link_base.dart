import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? hashtagStyle;
  final TextStyle? urlStyle;
  final Function(String)? onHashtagTap;
  final Function(String)? onUrlTap;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  const TextLink({
    super.key,
    required this.text,
    this.textStyle,
    this.hashtagStyle,
    this.urlStyle,
    this.onHashtagTap,
    this.onUrlTap,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;
    final effectiveTextStyle = textStyle ?? defaultStyle;
    final effectiveHashtagStyle =
        hashtagStyle ??
        effectiveTextStyle?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        );
    final effectiveUrlStyle =
        urlStyle ??
        effectiveTextStyle?.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        );

    final List<TextSpan> textSpans = [];
    String remainingText = text;

    // Regular expressions for hashtags and URLs
    final hashtagRegExp = RegExp(r'#\w+');
    final urlRegExp = RegExp(
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})',
      caseSensitive: false,
    );

    // Function to process matches
    void processMatches(RegExp regex, bool isHashtag) {
      final matches = regex.allMatches(remainingText);
      int lastEnd = 0;

      for (final match in matches) {
        // Add text before the match
        if (match.start > lastEnd) {
          textSpans.add(
            TextSpan(
              text: remainingText.substring(lastEnd, match.start),
              style: effectiveTextStyle,
            ),
          );
        }

        // Add the matched text (hashtag or URL)
        final matchedText = remainingText.substring(match.start, match.end);
        textSpans.add(
          TextSpan(
            text: matchedText,
            style: isHashtag ? effectiveHashtagStyle : effectiveUrlStyle,
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    if (isHashtag) {
                      onHashtagTap?.call(matchedText);
                    } else {
                      onUrlTap?.call(matchedText);
                    }
                  },
          ),
        );

        lastEnd = match.end;
      }

      // Add remaining text
      if (lastEnd < remainingText.length) {
        textSpans.add(
          TextSpan(
            text: remainingText.substring(lastEnd),
            style: effectiveTextStyle,
          ),
        );
      }
    }

    // Process URLs first
    processMatches(urlRegExp, false);

    // Update remaining text and process hashtags
    if (textSpans.isEmpty) {
      processMatches(hashtagRegExp, true);
    } else {
      // If we already have spans from URLs, we need to check each text span
      final List<TextSpan> finalSpans = [];
      for (final span in textSpans) {
        if (span.recognizer == null) {
          // Only process non-URL spans for hashtags
          final text = span.text ?? '';
          final hashtagMatches = hashtagRegExp.allMatches(text);
          int lastEnd = 0;

          for (final match in hashtagMatches) {
            if (match.start > lastEnd) {
              finalSpans.add(
                TextSpan(
                  text: text.substring(lastEnd, match.start),
                  style: effectiveTextStyle,
                ),
              );
            }

            final matchedText = text.substring(match.start, match.end);
            finalSpans.add(
              TextSpan(
                text: matchedText,
                style: effectiveHashtagStyle,
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () => onHashtagTap?.call(matchedText),
              ),
            );

            lastEnd = match.end;
          }

          if (lastEnd < text.length) {
            finalSpans.add(
              TextSpan(
                text: text.substring(lastEnd),
                style: effectiveTextStyle,
              ),
            );
          }
        } else {
          finalSpans.add(span);
        }
      }
      textSpans
        ..clear()
        ..addAll(finalSpans);
    }

    return RichText(
      text: TextSpan(children: textSpans),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
