import 'package:flutter/material.dart';
import 'package:qcf_quran/qcf_quran.dart';

/// A simple, reusable widget to display Arabic text with colored harakat
///
/// This widget makes it easy to display any Arabic text with harakat marks
/// in a different color from the base letters.
///
/// Example:
/// ```dart
/// HarakatTextDisplay(
///   text: 'السَّلاَمُ عَلَيْكُم',
///   letterColor: Colors.black,
///   harakatColor: Colors.red,
///   fontSize: 20,
/// )
/// ```
class HarakatTextDisplay extends StatelessWidget {
  /// The Arabic text containing harakat marks
  final String text;

  /// Color for base letters
  final Color letterColor;

  /// Color for harakat marks
  final Color harakatColor;

  /// Font size for letters
  final double fontSize;

  /// Font size for harakat (usually smaller than letters)
  /// If null, uses 80% of fontSize
  final double? harakatFontSize;

  /// Font weight for letters
  final FontWeight letterFontWeight;

  /// Font weight for harakat
  final FontWeight harakatFontWeight;

  /// Font family for letters
  final String? fontFamily;

  /// Text alignment
  final TextAlign textAlign;

  /// Height multiplier for line spacing
  final double lineHeightMultiplier;

  const HarakatTextDisplay({
    super.key,
    required this.text,
    this.letterColor = Colors.black,
    this.harakatColor = Colors.red,
    this.fontSize = 20,
    this.harakatFontSize,
    this.letterFontWeight = FontWeight.normal,
    this.harakatFontWeight = FontWeight.normal,
    this.fontFamily,
    this.textAlign = TextAlign.right,
    this.lineHeightMultiplier = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHarakatFontSize = harakatFontSize ?? fontSize * 0.8;

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      text: TextSpan(
        children: buildHarakatSpans(
          text,
          letterStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: letterFontWeight,
            fontFamily: fontFamily,
            height: lineHeightMultiplier,
          ),
          harakatStyle: TextStyle(
            fontSize: effectiveHarakatFontSize,
            fontWeight: harakatFontWeight,
            height: lineHeightMultiplier,
          ),
          letterColor: letterColor,
          harakatColor: harakatColor,
        ),
      ),
    );
  }
}

/// A card widget that displays text with analysis of harakat separation
///
/// Shows the original text, clean text (without harakat), and visual segments
class HarakatAnalysisCard extends StatefulWidget {
  final String text;
  final String title;
  final Color? backgroundColor;

  const HarakatAnalysisCard({
    super.key,
    required this.text,
    this.title = 'Harakat Analysis',
    this.backgroundColor,
  });

  @override
  State<HarakatAnalysisCard> createState() => _HarakatAnalysisCardState();
}

class _HarakatAnalysisCardState extends State<HarakatAnalysisCard> {
  bool _showSegments = false;

  @override
  Widget build(BuildContext context) {
    final segments = separateHarakat(widget.text);
    final cleanText = removeHarakat(widget.text);

    return Card(
      color: widget.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Original text with colored harakat
            const Text('Original text with colored harakat:'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: HarakatTextDisplay(
                text: widget.text,
                letterColor: Colors.black,
                harakatColor: Colors.red,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // Clean text
            const Text('Text without harakat:'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                cleanText,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),

            // Statistics
            _buildStatistics(segments),

            const SizedBox(height: 12),

            // Toggle segments view
            TextButton.icon(
              onPressed: () => setState(() => _showSegments = !_showSegments),
              icon: Icon(_showSegments ? Icons.expand_less : Icons.expand_more),
              label: Text(
                _showSegments
                    ? 'Hide segments'
                    : 'Show ${segments.length} segments',
              ),
            ),

            if (_showSegments) ...[
              const SizedBox(height: 12),
              _buildSegmentsList(segments),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(List<TextSegment> segments) {
    final letterCount = segments.where((s) => !s.isHarakat).length;
    final harakatCount = segments.where((s) => s.isHarakat).length;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                letterCount.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Text('Letters', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              Text(
                harakatCount.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const Text('Harakat', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              Text(
                segments.length.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const Text('Segments', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentsList(List<TextSegment> segments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Segments breakdown:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                segments
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(right: 4, bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                entry.value.isHarakat
                                    ? Colors.red.withOpacity(0.2)
                                    : Colors.blue.withOpacity(0.2),
                            border: Border.all(
                              color:
                                  entry.value.isHarakat
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${entry.value.text} (${entry.value.isHarakat ? 'H' : 'L'})',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  entry.value.isHarakat
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

/// A comparison widget showing text with and without harakat side by side
class HarakatComparisonWidget extends StatelessWidget {
  final String textWithHarakat;
  final String? title;

  const HarakatComparisonWidget({
    super.key,
    required this.textWithHarakat,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textWithoutHarakat = removeHarakat(textWithHarakat);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'With Harakat',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: HarakatTextDisplay(
                      text: textWithHarakat,
                      letterColor: Colors.black,
                      harakatColor: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Without Harakat',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      textWithoutHarakat,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
