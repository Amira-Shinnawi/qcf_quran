# Harakat/Tashkeel Separator - Complete Guide

A complete solution for separating Arabic diacritical marks (Harakat/Tashkeel) from text and rendering them with custom styling.

## Overview

This module provides:
- **Easy text separation**: Separate harakat marks from base Arabic letters
- **Color styling**: Render harakat in different colors (red) while keeping letters in black
- **High performance**: Efficient handling of large Quran JSON datasets
- **RTL support**: Full Right-to-Left text support
- **QCF font integration**: Works seamlessly with QCF fonts for authentic Quran rendering
- **Pre-built widgets**: Ready-to-use widgets for common scenarios

## Quick Start

### 1. Simplest Way: HarakatTextDisplay Widget

```dart
import 'package:qcf_quran/qcf_quran.dart';

HarakatTextDisplay(
  text: 'السَّلاَمُ عَلَيْكُم',
  letterColor: Colors.black,
  harakatColor: Colors.red,
  fontSize: 20,
)
```

### 2. With QcfVerse Widget

```dart
QcfVerse(
  surahNumber: 1,
  verseNumber: 1,
  fontSize: 28,
  textColor: Colors.black,       // Letters
  tashkeelColor: Colors.red,     // Harakat marks
  sp: 1.sp,
  h: 1.h,
)
```

### 3. Using buildHarakatSpans for RichText

```dart
RichText(
  textDirection: TextDirection.rtl,
  text: TextSpan(
    children: buildHarakatSpans(
      text: 'بِسۡمِ ٱللَّهِ',
      letterColor: Colors.black,
      harakatColor: Colors.red,
    ),
  ),
)
```

## API Reference

### Core Functions

#### `separateHarakat(String text) → List<TextSegment>`
Separates harakat from text into individual segments.

**Parameters:**
- `text`: Arabic text containing harakat marks

**Returns:** List of `TextSegment` objects with `text` and `isHarakat` properties

**Example:**
```dart
final segments = separateHarakat('السَّلاَمُ');
for (var seg in segments) {
  print('${seg.text} - IsHarakat: ${seg.isHarakat}');
}
```

---

#### `removeHarakat(String text) → String`
Removes all harakat marks from text.

**Parameters:**
- `text`: Arabic text with harakat

**Returns:** Text without any harakat marks

**Example:**
```dart
final clean = removeHarakat('السَّلاَمُ'); // السلام
```

---

#### `extractHarakat(String text) → String`
Extracts only the harakat marks from text.

**Parameters:**
- `text`: Arabic text containing harakat

**Returns:** String with only harakat marks

**Example:**
```dart
final marks = extractHarakat('السَّلاَمُ'); // Returns harakat marks only
```

---

#### `isHarakat(String char) → bool`
Checks if a single character is a harakat mark.

**Parameters:**
- `char`: Single character to check

**Returns:** `true` if character is harakat, `false` otherwise

**Example:**
```dart
print(isHarakat('َ')); // true
print(isHarakat('ا')); // false
```

---

#### `buildHarakatSpans(...) → List<InlineSpan>`
Builds text spans for RichText with separate styling.

**Parameters:**
- `text`: Arabic text with harakat
- `letterStyle`: Optional TextStyle for letters
- `harakatStyle`: Optional TextStyle for harakat
- `letterColor`: Color for letters
- `harakatColor`: Color for harakat marks
- `style`: Base TextStyle
- `recognizer`: Optional GestureRecognizer

**Returns:** List of InlineSpan for use in RichText

**Example:**
```dart
RichText(
  textDirection: TextDirection.rtl,
  text: TextSpan(
    children: buildHarakatSpans(
      text: 'السَّلاَمُ',
      letterStyle: const TextStyle(fontSize: 24),
      letterColor: Colors.black,
      harakatColor: Colors.red,
    ),
  ),
)
```

### Data Class

#### `TextSegment`
Represents a segment of text (letter or harakat).

```dart
class TextSegment {
  final String text;        // The actual text
  final bool isHarakat;     // Whether it's a harakat mark
}
```

### Pre-built Widgets

#### `HarakatTextDisplay`
Simple widget for displaying Arabic text with colored harakat.

**Parameters:**
- `text`: Arabic text with harakat (required)
- `letterColor`: Color for letters (default: Colors.black)
- `harakatColor`: Color for harakat (default: Colors.red)
- `fontSize`: Font size (default: 20)
- `harakatFontSize`: Font size for harakat (optional, defaults to 80% of fontSize)
- `letterFontWeight`: Font weight for letters
- `harakatFontWeight`: Font weight for harakat
- `fontFamily`: Font family name
- `textAlign`: Text alignment (default: TextAlign.right)
- `lineHeightMultiplier`: Line height multiplier (default: 1.5)

**Example:**
```dart
HarakatTextDisplay(
  text: 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
  letterColor: Colors.black87,
  harakatColor: Colors.red,
  fontSize: 24,
  lineHeightMultiplier: 1.8,
)
```

---

#### `HarakatAnalysisCard`
Interactive card showing harakat analysis and segments.

**Parameters:**
- `text`: Arabic text to analyze (required)
- `title`: Card title (default: 'Harakat Analysis')
- `backgroundColor`: Custom background color

**Features:**
- Shows text with colored harakat
- Shows clean text (without harakat)
- Displays statistics (letter count, harakat count)
- Expandable segment breakdown
- Interactive UI

**Example:**
```dart
HarakatAnalysisCard(
  text: 'بِسۡمِ ٱللَّهِ',
  title: 'Bismillah Analysis',
)
```

---

#### `HarakatComparisonWidget`
Side-by-side comparison of text with and without harakat.

**Parameters:**
- `textWithHarakat`: Text containing harakat (required)
- `title`: Optional comparison title

**Example:**
```dart
HarakatComparisonWidget(
  textWithHarakat: 'السَّلاَمُ',
  title: 'Arabic Text Comparison',
)
```

## Supported Harakat Ranges

The module recognizes these Unicode ranges as harakat:

- **U+0617..U+061A**: ARABIC SMALL FATHA through ARABIC DAMMATAN
- **U+064B..U+0652**: ARABIC FATHATAN through ARABIC SUKUN
- **U+0670**: ARABIC LETTER SUPERSCRIPT ALEF
- **U+06D6..U+06ED**: ARABIC SMALL HIGH LIGATURES

These cover all standard Arabic diacritical marks used in Quranic text.

## Real-World Examples

### Example 1: Display Single Verse with Colored Harakat

```dart
Widget buildQuranicVerse() {
  return Container(
    padding: EdgeInsets.all(16),
    child: HarakatTextDisplay(
      text: 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
      letterColor: Colors.black,
      harakatColor: Colors.red,
      fontSize: 28,
    ),
  );
}
```

### Example 2: Process Large Quran Dataset

```dart
void processQuranVerse(Map verse) {
  // Get clean text for storage/indexing
  final cleanText = removeHarakat(verse['content']);
  
  // Build UI with colored harakat
  final spans = buildHarakatSpans(
    text: verse['content'],
    letterColor: Colors.black,
    harakatColor: Colors.red,
  );
  
  // Display in RichText
  RichText(
    textDirection: TextDirection.rtl,
    text: TextSpan(children: spans),
  );
}
```

### Example 3: Educational Tool with Analysis

```dart
Widget educationalTool() {
  return HarakatAnalysisCard(
    text: 'السَّلاَمُ عَلَيْكُم',
    title: 'Harakat Analysis Tool',
  );
}
```

### Example 4: Text Cleaning for Search

```dart
void prepareTextForSearch(String arabicText) {
  // Remove harakat for faster/better search matching
  final searchText = removeHarakat(arabicText);
  
  // Use searchText for search queries
  final results = performSearch(searchText);
}
```

## Performance Tips

1. **Reuse segments**: If rendering the same text multiple times, cache the result of `separateHarakat()`
2. **Batch processing**: Process multiple verses at once using list operations
3. **Lazy loading**: Only process verses visible on screen
4. **Caching**: Store clean text separately for faster access

Example:
```dart
// Cache segments for reuse
final segmentsCache = <String, List<TextSegment>>{};

List<TextSegment> getCachedSegments(String text) {
  if (!segmentsCache.containsKey(text)) {
    segmentsCache[text] = separateHarakat(text);
  }
  return segmentsCache[text]!;
}
```

## Integration with QcfVerse

The `QcfVerse` widget has built-in support for harakat coloring:

```dart
QcfVerse(
  surahNumber: 2,
  verseNumber: 255,  // Ayat al-Kursi
  fontSize: 24,
  textColor: Colors.black,      // Base letters
  tashkeelColor: Colors.red,    // Harakat marks
  sp: 1.sp,
  h: 1.h,
)
```

This is the recommended way to display Quranic text with colored harakat since it:
- Uses QCF fonts for authentic rendering
- Handles page-based font sizing
- Supports verse numbers
- Provides responsive scaling

## Testing

The example project includes:
- **HarakatSeparatorExamplePage**: Comprehensive examples with 8+ use cases
- **Interactive widgets**: Test different styling combinations
- **Real Quranic verses**: See live examples with actual Quran text

To run examples:
```bash
cd example
flutter run
```

Then navigate to "Harakat Separation Examples" in the app.

## Common Questions

### Q: Why are harakat marks not visible in QCF fonts?
**A:** QCF fonts are specialized ligature fonts for rendering Quran pages. The harakat marks are baked into the glyphs. Use `tashkeelColor` parameter in QcfVerse to highlight them.

### Q: Can I store only clean text and render with harakat?
**A:** Yes! This is recommended. Store clean text (`removeHarakat(text)`) for storage and use a mapping file or database to get the full text with harakat when rendering.

### Q: Is this compatible with flutter_screenutil?
**A:** Yes! All examples use `flutter_screenutil` for responsive sizing. Pass `1.sp` and `1.h` to widgets.

### Q: How do I change harakat font size?
**A:** Use the `harakatFontSize` parameter in `HarakatTextDisplay` or `harakatStyle` in `buildHarakatSpans`.

### Q: Can I use custom colors?
**A:** Yes! All widgets support `letterColor` and `harakatColor` parameters. You can use any `Color` from Flutter.

## License

This module is part of the qcf_quran package and follows the same license.

## Support

For issues, questions, or feature requests, please refer to the main qcf_quran package documentation.
