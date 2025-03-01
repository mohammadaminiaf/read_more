import 'package:flutter/material.dart';
import 'package:readmore_flutter/src/text_link_base.dart';

class BlurredReadMore extends StatefulWidget {
  final String text;
  final int minLines;
  final int extraBlurLines;
  final double blurHeight;
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
    this.blurHeight = 20.0,
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
  bool isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = const TextStyle(
      fontSize: 15,
      color: Colors.black,
    );
    final effectiveTextStyle = widget.style ?? defaultTextStyle;

    return ListView(
      shrinkWrap: true,
      children: [
        // Text with Blur
        Stack(
          children: [
            TextLink(
              text: widget.text,
              textStyle: effectiveTextStyle,
              maxLines:
                  isExpanded ? 10000 : widget.minLines + widget.extraBlurLines,
              overflow: TextOverflow.ellipsis,
              hashtagStyle: widget.hashtagStyle,
              urlStyle: widget.urlStyle,
              onHashtagTap: widget.onHashtagTap,
              onUrlTap: widget.onUrlTap,
              textAlign: widget.textAlign,
            ),

            // Blurred Overlay (Only when in Read Less mode)
            if (!isExpanded)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: widget.blurHeight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.blurColor.withAlpha(0),
                        widget.blurColor.withAlpha(180),
                        widget.blurColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
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
              isExpanded ? widget.expandedIcon : widget.collapsedIcon,
              size: widget.iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
