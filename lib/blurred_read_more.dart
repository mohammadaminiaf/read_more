import 'package:flutter/material.dart';

extension BlurredReadMore on Widget {
  /// Adds a "Read More" blur effect to text.
  Widget blurredReadMore({
    required String text,
    required bool isExpanded,
    required VoidCallback onToggle,
    int minLines = 3,
    int extraBlurLines = 2,
    double blurHeight = 20.0,
    Color blurColor = Colors.white,
    TextStyle? textStyle,
    double iconSize = 30.0,
  }) {
    final TextStyle defaultTextStyle = const TextStyle(fontSize: 15);
    final effectiveTextStyle = textStyle ?? defaultTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text with Blur
        Stack(
          children: [
            Text(
              text,
              style: effectiveTextStyle,
              maxLines: isExpanded ? null : minLines + extraBlurLines,
              overflow: TextOverflow.ellipsis,
            ),

            // Blurred Overlay (Only when in Read Less mode)
            if (!isExpanded)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: blurHeight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        blurColor.withOpacity(0.0),
                        blurColor.withOpacity(0.7),
                        blurColor,
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
            onPressed: onToggle,
            icon: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
