import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qcf_quran/qcf_quran.dart';

void main() {
  test('convertToArabicNumber converts western digits to Arabic-Indic', () {
    expect(convertToArabicNumber('123'), '\u0661\u0662\u0663');
  });

  test('isTashkeel supports required Quran diacritic ranges', () {
    expect(isTashkeel('\u0617'), isTrue);
    expect(isTashkeel('\u061A'), isTrue);
    expect(isTashkeel('\u064B'), isTrue);
    expect(isTashkeel('\u0652'), isTrue);
    expect(isTashkeel('\u0670'), isTrue);
    expect(isTashkeel('\u06D6'), isTrue);
    expect(isTashkeel('\u06ED'), isTrue);
    expect(isTashkeel('\u0627'), isFalse);
  });

  test('buildQuranTextSpans preserves text and groups tashkeel runs', () {
    const text = '\u0671\u0644\u0631\u0651\u064E';
    final spans =
        buildQuranTextSpans(
          text,
          letterStyle: const TextStyle(color: Color(0xFF000000)),
          tashkeelStyle: const TextStyle(color: Color(0xFFFF0000)),
        ).cast<TextSpan>();

    expect(spans.map((span) => span.text).join(), text);
    expect(spans.map((span) => span.text), [
      '\u0671\u0644\u0631',
      '\u0651\u064E',
    ]);
    expect(spans.last.style?.color, const Color(0xFFFF0000));
  });
}
