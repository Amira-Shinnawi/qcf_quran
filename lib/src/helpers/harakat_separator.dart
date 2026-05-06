import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Represents a segment of text with its type (letter or harakat)
class TextSegment {
  final String text;
  final bool isHarakat;

  TextSegment({required this.text, required this.isHarakat});

  @override
  String toString() => 'TextSegment(text: "$text", isHarakat: $isHarakat)';
}

/// Checks if a code point is an Arabic harakat/diacritical mark
bool _isHarakatCodePoint(int codePoint) {
  return (codePoint >= 0x0610 && codePoint <= 0x061A) ||
      (codePoint >= 0x064B && codePoint <= 0x065F) ||
      codePoint == 0x0670 ||
      (codePoint >= 0x06D6 && codePoint <= 0x06ED) ||
      codePoint == 0x061C ||
      (codePoint >= 0x08D3 && codePoint <= 0x08FF);
}

/// Returns true if the character is a single Arabic harakat
bool isHarakat(String char) {
  if (char.isEmpty) return false;
  final runes = char.runes.toList();
  if (runes.length != 1) return false;
  return _isHarakatCodePoint(runes.first);
}

/// Separates harakat from Arabic text into individual segments
///
/// Returns a list of [TextSegment] objects where each segment is either
/// a letter or a harakat mark.
///
/// Example:
/// ```dart
/// final segments = separateHarakat('السَّلاَمُ');
/// // Returns:
/// // [TextSegment(text: 'ا', isHarakat: false),
/// //  TextSegment(text: 'ل', isHarakat: false),
/// //  TextSegment(text: 'َ', isHarakat: true),
/// //  TextSegment(text: 'ّ', isHarakat: true),
/// //  TextSegment(text: 'ل', isHarakat: false),
/// //  ...]
/// ```
List<TextSegment> separateHarakat(String text) {
  if (text.isEmpty) return [];

  final segments = <TextSegment>[];

  for (final codePoint in text.runes) {
    final char = String.fromCharCode(codePoint);
    final isHarakatChar = _isHarakatCodePoint(codePoint);

    // Check if we can merge with the last segment
    if (segments.isNotEmpty && segments.last.isHarakat == isHarakatChar) {
      segments.last = TextSegment(
        text: segments.last.text + char,
        isHarakat: isHarakatChar,
      );
    } else {
      segments.add(TextSegment(text: char, isHarakat: isHarakatChar));
    }
  }

  return segments;
}

/// Returns only the base letters (without harakat)
String removeHarakat(String text) {
  if (text.isEmpty) return '';
  return String.fromCharCodes(
    text.runes.where((codePoint) => !_isHarakatCodePoint(codePoint)),
  );
}

/// Returns only the harakat marks
String extractHarakat(String text) {
  if (text.isEmpty) return '';
  return String.fromCharCodes(
    text.runes.where((codePoint) => _isHarakatCodePoint(codePoint)),
  );
}

/// Builds text spans for Quranic text with separate styling for harakat and letters
///
/// Parameters:
/// - [text]: The Arabic text containing harakat
/// - [letterStyle]: Style for base letters
/// - [harakatStyle]: Style for harakat marks
/// - [letterColor]: Color for base letters (overrides style color)
/// - [harakatColor]: Color for harakat marks (overrides style color)
/// - [style]: Base style applied to all text
/// - [recognizer]: Optional gesture recognizer
///
/// Example:
/// ```dart
/// RichText(
///   textDirection: TextDirection.rtl,
///   text: TextSpan(
///     children: buildHarakatSpans(
///       text: 'السَّلاَم',
///       letterStyle: const TextStyle(fontSize: 24),
///       letterColor: Colors.black,
///       harakatColor: Colors.red,
///     ),
///   ),
/// )
/// ```
List<InlineSpan> buildHarakatSpans(
  String text, {
  TextStyle? letterStyle,
  TextStyle? harakatStyle,
  Color? letterColor,
  Color? harakatColor,
  TextStyle? style,
  GestureRecognizer? recognizer,
}) {
  if (text.isEmpty) return [];

  final baseLetterStyle = (letterStyle ?? style ?? const TextStyle()).copyWith(
    color: letterColor ?? letterStyle?.color ?? style?.color,
  );

  final baseHarakatStyle = (harakatStyle ?? style ?? const TextStyle())
      .copyWith(color: harakatColor ?? harakatStyle?.color ?? style?.color);

  // If no styling is provided, return a single span
  if (harakatColor == null &&
      harakatStyle == null &&
      letterColor == null &&
      letterStyle == null &&
      style == null) {
    return [TextSpan(text: text, recognizer: recognizer)];
  }

  final segments = separateHarakat(text);
  return segments
      .map(
        (segment) => TextSpan(
          text: segment.text,
          style: segment.isHarakat ? baseHarakatStyle : baseLetterStyle,
          recognizer: recognizer,
        ),
      )
      .toList();
}
