import 'package:flutter/material.dart';
import 'package:readmore_flutter/src/text_link_base.dart';

class ReadMore extends StatefulWidget {
  final String text;
  final int minLines;
  final TextStyle? textStyle;
  final TextStyle? readMoreStyle;
  final String readMoreText;
  final String readLessText;
  final bool readMoreIconVisible;
  final IconData readMoreIcon;
  final IconData readLessIcon;
  final double iconSize;
  final bool alignCenter;
  final int extraBlurLines;
  final double blurHeight;
  final Color blurColor;
  final TextStyle? hashtagStyle;
  final TextStyle? urlStyle;
  final Function(String)? onHashtagTap;
  final Function(String)? onUrlTap;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  const ReadMore({
    super.key,
    required this.text,
    this.minLines = 3,
    this.textStyle,
    this.readMoreStyle,
    this.readMoreText = 'Read more',
    this.readLessText = 'Read less',
    this.readMoreIconVisible = true,
    this.readMoreIcon = Icons.keyboard_arrow_down,
    this.readLessIcon = Icons.keyboard_arrow_up,
    this.iconSize = 20,
    this.alignCenter = false,
    this.extraBlurLines = 2,
    this.blurHeight = 20.0,
    this.blurColor = Colors.white,
    this.hashtagStyle,
    this.urlStyle,
    this.onHashtagTap,
    this.onUrlTap,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
  });

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  bool _isExpanded = false;
  bool _needsReadMore = false;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodyMedium;
    final effectiveTextStyle = widget.textStyle ?? defaultTextStyle;
    final effectiveReadMoreStyle =
        widget.readMoreStyle ??
        effectiveTextStyle?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: widget.text, style: effectiveTextStyle);

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: widget.minLines,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        _needsReadMore = textPainter.didExceedMaxLines;

        if (!_needsReadMore) {
          return Text(widget.text, style: effectiveTextStyle);
        }

        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: Column(
              crossAxisAlignment:
                  widget.alignCenter
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: TextLink(
                    text: widget.text,
                    hashtagStyle: widget.hashtagStyle,
                    onHashtagTap: widget.onHashtagTap,
                    onUrlTap: widget.onUrlTap,
                    textAlign: widget.textAlign,
                    textStyle: widget.textStyle,
                    urlStyle: widget.urlStyle,
                    maxLines: _isExpanded ? null : widget.minLines,
                    overflow:
                        _isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    mainAxisSize:
                        widget.alignCenter
                            ? MainAxisSize.min
                            : MainAxisSize.max,
                    mainAxisAlignment:
                        widget.alignCenter
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          _isExpanded
                              ? widget.readLessText
                              : widget.readMoreText,
                          style: effectiveReadMoreStyle,
                        ),
                      ),
                      if (widget.readMoreIconVisible) ...[
                        const SizedBox(width: 4),
                        Icon(
                          _isExpanded
                              ? widget.readLessIcon
                              : widget.readMoreIcon,
                          size: widget.iconSize,
                          color: effectiveReadMoreStyle?.color,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
