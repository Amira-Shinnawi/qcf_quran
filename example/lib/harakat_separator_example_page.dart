import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qcf_quran/qcf_quran.dart';

/// Example page demonstrating Harakat (diacritical marks) separation
///
/// This page demonstrates how to:
/// - Separate harakat from Arabic text
/// - Render harakat in different colors (red) from base letters (black)
/// - Use QcfVerseWidget with harakat separation
/// - Handle RTL text properly
class HarakatSeparatorExamplePage extends StatefulWidget {
  const HarakatSeparatorExamplePage({super.key});

  @override
  State<HarakatSeparatorExamplePage> createState() =>
      _HarakatSeparatorExamplePageState();
}

class _HarakatSeparatorExamplePageState
    extends State<HarakatSeparatorExamplePage> {
  // Sample Quranic text with harakat
  final String sampleTextWithHarakat = 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ';
  final String sampleTextWithoutHarakat = 'بسم الله الرحمن الرحيم';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harakat Separator Examples'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              '📝 Harakat (Tashkeel) Separation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Learn how to separate and style harakat marks (diacritical marks) '
              'from Arabic text. Harakat can be rendered in different colors while '
              'base letters maintain their own styling.',
            ),
            const Divider(height: 32),

            // Example 1: Basic Separation
            _buildExampleCard(
              context,
              title: '1. Basic Harakat Separation',
              description: 'Shows text analysis with harakat separated',
              child: _buildBasicSeparationExample(),
            ),

            const SizedBox(height: 24),

            // Example 2: Visual Rendering with Colors
            _buildExampleCard(
              context,
              title: '2. Visual Rendering (Red Harakat)',
              description: 'Harakat in red, letters in black',
              child: _buildColoredHarakatExample(),
            ),

            const SizedBox(height: 24),

            // Example 3: With QCF Font
            _buildExampleCard(
              context,
              title: '3. QCF Font with Harakat Styling',
              description: 'Use with QCF fonts for authentic Quran rendering',
              child: _buildQcfHarakatExample(),
            ),

            const SizedBox(height: 24),

            // Example 4: Utility Functions
            _buildExampleCard(
              context,
              title: '4. Utility Functions',
              description: 'Remove or extract harakat programmatically',
              child: _buildUtilityFunctionsExample(),
            ),

            const SizedBox(height: 24),

            // Example 5: Real Quranic Verse
            _buildExampleCard(
              context,
              title: '5. Real Quranic Verse (Surah 1:1)',
              description: 'Bismillah with harakat styling',
              child: _buildRealVerseExample(),
            ),

            const SizedBox(height: 24),

            // Example 6: HarakatTextDisplay Widget
            _buildExampleCard(
              context,
              title: '6. HarakatTextDisplay Widget (Easiest)',
              description: 'Simple widget for colored harakat display',
              child: _buildHarakatTextDisplayExample(),
            ),

            const SizedBox(height: 24),

            // Example 7: HarakatAnalysisCard Widget
            _buildExampleCard(
              context,
              title: '7. HarakatAnalysisCard Widget',
              description: 'Interactive analysis of text segments',
              child: _buildHarakatAnalysisCardExample(),
            ),

            const SizedBox(height: 24),

            // Example 8: Comparison Widget
            _buildExampleCard(
              context,
              title: '8. HarakatComparisonWidget',
              description: 'Side-by-side comparison',
              child: _buildComparisonWidgetExample(),
            ),

            const SizedBox(height: 24),

            // Documentation
            _buildDocumentationCard(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Example 1: Basic separation showing text segments
  Widget _buildBasicSeparationExample() {
    final segments = separateHarakat(sampleTextWithHarakat);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input: $sampleTextWithHarakat',
          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 12),
        const Text('Separated segments:'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 8,
          children:
              segments
                  .map(
                    (segment) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            segment.isHarakat
                                ? Colors.red.withOpacity(0.2)
                                : Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: segment.isHarakat ? Colors.red : Colors.blue,
                        ),
                      ),
                      child: Text(
                        '${segment.text} (${segment.isHarakat ? 'H' : 'L'})',
                        style: TextStyle(
                          fontSize: 12,
                          color: segment.isHarakat ? Colors.red : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  /// Example 2: Colored harakat rendering
  Widget _buildColoredHarakatExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Standard rendering:'),
        const SizedBox(height: 8),
        RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            children: buildHarakatSpans(
              sampleTextWithHarakat,
              letterStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              letterColor: Colors.black,
              harakatColor: Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('With different styling:'),
        const SizedBox(height: 8),
        RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            children: buildHarakatSpans(
              sampleTextWithHarakat,
              letterStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              harakatStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              letterColor: Colors.black87,
              harakatColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  /// Example 3: Using with QCF font
  Widget _buildQcfHarakatExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rendering with QCF font and harakat styling:'),
        const SizedBox(height: 12),
        // QcfVerse widget which already supports tashkeelColor
        QcfVerse(
          surahNumber: 1,
          verseNumber: 1,
          fontSize: 24,
          tashkeelColor: Colors.red, // Harakat in red
          textColor: Colors.black, // Letters in black
          sp: 1.sp,
          h: 1.h,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            '💡 Note: QcfVerse widget automatically handles harakat '
            'coloring using the tashkeelColor parameter while rendering '
            'with QCF ligature fonts.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  /// Example 4: Utility functions
  Widget _buildUtilityFunctionsExample() {
    final withoutHarakat = removeHarakat(sampleTextWithHarakat);
    final justHarakat = extractHarakat(sampleTextWithHarakat);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCodeBlock(
          'removeHarakat(text)',
          'Removes all harakat marks from text',
          'Input:  $sampleTextWithHarakat\nOutput: $withoutHarakat',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'extractHarakat(text)',
          'Extracts only harakat marks',
          'Input:   $sampleTextWithHarakat\nOutput: "$justHarakat"',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'separateHarakat(text)',
          'Separates text into segments',
          'Returns: List<TextSegment>',
        ),
      ],
    );
  }

  /// Example 5: Real Quranic verse with harakat
  Widget _buildRealVerseExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Surah 1, Verse 1 (Bismillah)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Text(
                'With QCF Font & Harakat Styling:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              QcfVerse(
                surahNumber: 1,
                verseNumber: 1,
                fontSize: 28,
                tashkeelColor: Colors.red,
                textColor: Colors.black,
                sp: 1.sp,
                h: 1.h,
              ),
              const SizedBox(height: 12),
              const Text(
                'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ\n(In the name of Allah, the Most Gracious, the Most Merciful)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Example 6: HarakatTextDisplay Widget - The easiest way!
  Widget _buildHarakatTextDisplayExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Simplest way to display colored harakat:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        HarakatTextDisplay(
          text: 'السَّلاَمُ عَلَيْكُم وَرَحْمَةُ الله وَبَرَكَاتُهُ',
          letterColor: Colors.black,
          harakatColor: Colors.red,
          fontSize: 20,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.green),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✅ Just use HarakatTextDisplay!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'HarakatTextDisplay is the simplest widget to display '
                'Arabic text with colored harakat. Just provide the text, '
                'colors, and font size!',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Example 7: HarakatAnalysisCard - Interactive analysis
  Widget _buildHarakatAnalysisCardExample() {
    return HarakatAnalysisCard(
      text: 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
      title: 'Bismillah Analysis',
    );
  }

  /// Example 8: Comparison widget
  Widget _buildComparisonWidgetExample() {
    return HarakatComparisonWidget(
      textWithHarakat: 'ٱلۡحَمۡدُ لِلَّهِ رَبِّ ٱلۡعَٰلَمِينَ',
      title: 'Al-Hamdu (Surah 1:2)',
    );
  }

  /// Documentation card
  Widget _buildDocumentationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📚 API Reference',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.teal),
          ),
          const SizedBox(height: 12),
          _buildApiDocItem(
            'separateHarakat(String text)',
            'List<TextSegment>',
            'Separates text into base letters and harakat marks. '
                'Returns a list of segments with isHarakat flag.',
          ),
          const SizedBox(height: 12),
          _buildApiDocItem(
            'removeHarakat(String text)',
            'String',
            'Returns text with all harakat marks removed.',
          ),
          const SizedBox(height: 12),
          _buildApiDocItem(
            'extractHarakat(String text)',
            'String',
            'Returns only the harakat marks from the text.',
          ),
          const SizedBox(height: 12),
          _buildApiDocItem(
            'isHarakat(String char)',
            'bool',
            'Checks if a single character is a harakat mark.',
          ),
          const SizedBox(height: 12),
          _buildApiDocItem(
            'buildHarakatSpans(...)',
            'List<InlineSpan>',
            'Builds text spans for RichText with separate styling '
                'for harakat and base letters. Supports custom colors and styles.',
          ),
        ],
      ),
    );
  }

  /// Helper: Code block display
  Widget _buildCodeBlock(String title, String description, String code) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Text(
              code,
              style: const TextStyle(fontFamily: 'Courier', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: API doc item
  Widget _buildApiDocItem(
    String signature,
    String returns,
    String description,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                signature,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '→ $returns',
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 11,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  /// Helper: Example card
  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
