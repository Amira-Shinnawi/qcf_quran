import 'package:flutter/material.dart';
import 'package:qcf_quran/src/helpers/quran_text_processor.dart';

/// A widget that renders standard Arabic Quran text (from the "content" field)
/// with separate colors for letters and diacritics (tashkeel).
class QuranContentVerse extends StatelessWidget {
  /// The standard Arabic text to display.
  final String content;

  /// The color of the Arabic letters.
  final Color letterColor;

  /// The color of the Arabic diacritics (tashkeel).
  final Color tashkeelColor;

  /// The font size of the text.
  final double fontSize;

  /// The font family to use for the text.
  final String? fontFamily;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  final TextDirection textDirection;

  const QuranContentVerse({
    super.key,
    required this.content,
    this.letterColor = Colors.black,
    this.tashkeelColor = Colors.red,
    this.fontSize = 22.0,
    this.fontFamily,
    this.textAlign = TextAlign.center,
    this.textDirection = TextDirection.rtl,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      textDirection: textDirection,
      text: TextSpan(
        children: QuranTextProcessor.buildSpans(
          text: content,
          letterStyle: TextStyle(
            color: letterColor,
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
          tashkeelStyle: TextStyle(
            color: tashkeelColor,
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }
}
