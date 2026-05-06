import 'package:flutter/widgets.dart';
import 'package:qcf_quran/src/helpers/tashkeel_span_helper.dart';

/// A class representing a single Arabic character and whether it is a Tashkeel (diacritic).
class ArabicChar {
  final String char;
  final bool isTashkeel;

  ArabicChar({required this.char, required this.isTashkeel});

  /// Converts the character to a map suitable for JSON serialization.
  Map<String, dynamic> toMap() => {"char": char, "isTashkeel": isTashkeel};

  @override
  String toString() => 'ArabicChar(char: $char, isTashkeel: $isTashkeel)';
}

/// Efficient processor for Quranic Arabic text to separate letters and diacritics.
class QuranTextProcessor {
  /// Detects if a character is an Arabic Tashkeel (diacritic) based on specific Unicode ranges.
  ///
  /// The ranges follow the user's requirements:
  /// - \u0617-\u061A (Small high ligatures)
  /// - \u064B-\u0652 (Standard Tashkeel: Fathatan to Sukun)
  /// - \u0670 (Superscript Alef)
  /// - \u06D6-\u06ED (Quranic small signs and marks)
  static bool isArabicTashkeel(int codePoint) {
    return isTashkeel(String.fromCharCode(codePoint));
  }

  /// Processes a string and returns a list of [ArabicChar] objects.
  /// Suitable for custom data processing or mapping to other structures.
  static List<ArabicChar> process(String text) {
    return text.runes.map((rune) {
      return ArabicChar(
        char: String.fromCharCode(rune),
        isTashkeel: isArabicTashkeel(rune),
      );
    }).toList();
  }

  /// Converts a string into a list of maps, matching the user's expected JSON-like structure.
  static List<Map<String, dynamic>> getStructure(String text) {
    return process(text).map((e) => e.toMap()).toList();
  }

  /// Efficiently builds a list of [InlineSpan] for Flutter's RichText or Text.rich.
  ///
  /// This method groups consecutive characters of the same type (Letter or Tashkeel)
  /// into a single [TextSpan] to improve rendering performance.
  static List<InlineSpan> buildSpans({
    required String text,
    required TextStyle letterStyle,
    required TextStyle tashkeelStyle,
  }) => buildQuranTextSpans(
    text,
    letterStyle: letterStyle,
    tashkeelStyle: tashkeelStyle,
  );
}
