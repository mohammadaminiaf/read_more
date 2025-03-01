import 'package:flutter/material.dart';
import 'package:readmore_flutter/src/text_link_base.dart';

class BlurredReadMore extends StatefulWidget {
  final String text;
  final int minLines;
  final int extraBlurLines;
  final Color blurColor;
  final TextStyle? style;
  final double iconSize;
  final TextStyle? hashtagStyle;
  final TextStyle? urlStyle;
  final Function(String)? onHashtagTap;
  final Function(String)? onUrlTap;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final IconData collapsedIcon;
  final IconData expandedIcon;

  const BlurredReadMore(
    this.text, {
    super.key,
    this.minLines = 3,
    this.extraBlurLines = 2,
    this.blurColor = Colors.white,
    this.style,
    this.iconSize = 30.0,
    this.hashtagStyle,
    this.urlStyle,
    this.onHashtagTap,
    this.onUrlTap,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.collapsedIcon = Icons.keyboard_arrow_down,
    this.expandedIcon = Icons.keyboard_arrow_up,
  });

  @override
  State<BlurredReadMore> createState() => _BlurredReadMoreState();
}

class _BlurredReadMoreState extends State<BlurredReadMore> {
  bool _isExpanded = false;
  bool _needsReadMore = false;
  TextStyle? _effectiveTextStyle;
  double? _lineHeight;
  
  @override
  void initState() {
	super.initState();
	_effectiveTextStyle = widget.style;
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // Calculate the height of a single line of text
  double _calculateLineHeight(BoxConstraints constraints) {
    if (_lineHeight != null) return _lineHeight!;

    final textPainter = TextPainter(
      text: TextSpan(text: 'Test Line', style: _effectiveTextStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: constraints.maxWidth);
    _lineHeight = textPainter.height;
    textPainter.dispose();
    return _lineHeight!;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: _effectiveTextStyle),
          maxLines: widget.minLines,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        _needsReadMore = textPainter.didExceedMaxLines;
        textPainter.dispose();

        if (!_needsReadMore) {
          return TextLink(
            text: widget.text,
            textStyle: _effectiveTextStyle,
            hashtagStyle: widget.hashtagStyle,
            urlStyle: widget.urlStyle,
            onHashtagTap: widget.onHashtagTap,
            onUrlTap: widget.onUrlTap,
            textAlign: widget.textAlign,
          );
        }

        final lineHeight = _calculateLineHeight(constraints);
        final blurHeight = lineHeight * widget.extraBlurLines;

        return Column(
          children: [
            // Text with Blur
            Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: TextLink(
                    text: widget.text,
                    textStyle: _effectiveTextStyle,
                    maxLines:
                        _isExpanded
                            ? 100000
                            : widget.minLines + widget.extraBlurLines,
                    overflow: TextOverflow.ellipsis,
                    hashtagStyle: widget.hashtagStyle,
                    urlStyle: widget.urlStyle,
                    onHashtagTap: widget.onHashtagTap,
                    onUrlTap: widget.onUrlTap,
                    textAlign: widget.textAlign,
                  ),
                ),

                // Blurred Overlay
                if (!_isExpanded)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: blurHeight,
                    child: ClipRect(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              widget.blurColor.withAlpha(70),
                              widget.blurColor.withAlpha(100),
                              widget.blurColor.withAlpha(140),
                              widget.blurColor.withAlpha(180),
                              widget.blurColor.withAlpha(220),
                              widget.blurColor,
                            ],
                            stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Read More Button
            Center(
              child: IconButton(
                onPressed: _toggleExpanded,
                icon: Icon(
                  _isExpanded ? widget.expandedIcon : widget.collapsedIcon,
                  size: widget.iconSize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
