import 'package:flutter/material.dart';
import 'package:qcf_quran/src/helpers/tashkeel_span_helper.dart';

/// Minimal example for rendering Quran text with separate letter/tashkeel colors.
class QuranTashkeelExample extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const QuranTashkeelExample({
    super.key,
    this.text = 'ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        style ??
        Theme.of(context).textTheme.headlineMedium ??
        const TextStyle();

    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      locale: const Locale('ar'),
      text: TextSpan(
        children: buildQuranTextSpans(
          text,
          letterStyle: baseStyle.copyWith(color: Colors.black),
          tashkeelStyle: baseStyle.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
