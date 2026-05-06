import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

bool _isTashkeelCodePoint(int codePoint) {
  return (codePoint >= 0x0610 && codePoint <= 0x061A) ||
      (codePoint >= 0x064B && codePoint <= 0x065F) ||
      codePoint == 0x0670 ||
      (codePoint >= 0x06D6 && codePoint <= 0x06ED) ||
      (codePoint >= 0x08D3 && codePoint <= 0x08FF);
}

/// Returns true when [char] is one Arabic diacritic/tashkeel code point.
///
/// Supported ranges:
/// - U+0617..U+061A
/// - U+064B..U+0652
/// - U+0670
/// - U+06D6..U+06ED
bool isTashkeel(String char) {
  if (char.isEmpty) return false;
  final iterator = char.runes.iterator;
  if (!iterator.moveNext()) return false;
  final first = iterator.current;
  return !iterator.moveNext() && _isTashkeelCodePoint(first);
}

/// Backwards-compatible code-point API.
bool isArabicTashkeel(int codePoint) => _isTashkeelCodePoint(codePoint);

/// Builds performant spans for Quran text while preserving every code point.
///
/// Consecutive letters and consecutive tashkeel are grouped into runs, which
/// keeps large Quran pages much cheaper than creating one [TextSpan] per mark.
List<InlineSpan> buildQuranTextSpans(
  String text, {
  TextStyle? letterStyle,
  TextStyle? tashkeelStyle,
  Color? letterColor,
  Color? tashkeelColor,
  TextStyle? style,
  GestureRecognizer? recognizer,
}) {
  if (text.isEmpty) return const [];

  final baseLetterStyle = (letterStyle ?? style ?? const TextStyle()).copyWith(
    color: letterColor ?? letterStyle?.color ?? style?.color,
  );
  final baseTashkeelStyle =
      tashkeelStyle ??
      (letterStyle ?? style ?? const TextStyle()).copyWith(
        color:
            tashkeelColor ?? letterColor ?? letterStyle?.color ?? style?.color,
      );

  if (tashkeelColor == null &&
      tashkeelStyle == null &&
      letterColor == null &&
      letterStyle == null) {
    return [TextSpan(text: text, style: style, recognizer: recognizer)];
  }

  final spans = <InlineSpan>[];
  final buffer = StringBuffer();
  bool? currentIsTashkeel;

  void flush() {
    if (buffer.isEmpty) return;
    spans.add(
      TextSpan(
        text: buffer.toString(),
        style: currentIsTashkeel == true ? baseTashkeelStyle : baseLetterStyle,
        recognizer: recognizer,
      ),
    );
    buffer.clear();
  }

  for (final codePoint in text.runes) {
    final charIsTashkeel = _isTashkeelCodePoint(codePoint);
    if (currentIsTashkeel != null && currentIsTashkeel != charIsTashkeel) {
      flush();
    }
    currentIsTashkeel = charIsTashkeel;
    buffer.write(String.fromCharCode(codePoint));
  }
  flush();

  return spans;
}

List<InlineSpan> buildTashkeelTextSpans({
  required String text,
  required TextStyle style,
  Color? tashkeelColor,
  GestureRecognizer? recognizer,
}) => buildQuranTextSpans(
  text,
  style: style,
  tashkeelColor: tashkeelColor,
  recognizer: recognizer,
);
