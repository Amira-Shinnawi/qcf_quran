import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

bool isArabicTashkeel(int codePoint) {
  return (codePoint >= 0x0610 && codePoint <= 0x061A) ||
      (codePoint >= 0x064B && codePoint <= 0x065F) ||
      codePoint == 0x0670 ||
      (codePoint >= 0x06D6 && codePoint <= 0x06ED);
}

List<InlineSpan> buildTashkeelTextSpans({
  required String text,
  required TextStyle style,
  Color? tashkeelColor,
  GestureRecognizer? recognizer,
}) {
  if (text.isEmpty) return const [];
  if (tashkeelColor == null) {
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
        style:
            currentIsTashkeel == true
                ? style.copyWith(color: tashkeelColor)
                : style,
        recognizer: recognizer,
      ),
    );
    buffer.clear();
  }

  for (final codePoint in text.runes) {
    final charIsTashkeel = isArabicTashkeel(codePoint);
    if (currentIsTashkeel != null && currentIsTashkeel != charIsTashkeel) {
      flush();
    }
    currentIsTashkeel = charIsTashkeel;
    buffer.write(String.fromCharCode(codePoint));
  }
  flush();

  return spans;
}
