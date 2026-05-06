/// Harakat Separator - Comprehensive Guide
/// ========================================
/// 
/// This guide explains how to use the Harakat separator module to separate
/// diacritical marks from Arabic text and apply custom styling.
/// 
/// ## What is Harakat?
/// 
/// Harakat (also spelled Tashkeel) are diacritical marks placed above or below
/// Arabic letters to indicate vowels and other pronunciations:
/// 
/// - ـَ (Fatha) - Indicates 'a' sound
/// - ـُ (Damma) - Indicates 'u' sound  
/// - ـِ (Kasra) - Indicates 'i' sound
/// - ـْ (Sukun) - Indicates no vowel
/// - ـّ (Shadda) - Indicates doubled letter
/// 
/// Example text: السَّلام (As-salaam - with harakat)
///          vs: السلام (As-salaam - without harakat)
/// 
/// ## Core Functions
/// 
/// ### 1. separateHarakat(String text) → List<TextSegment>
/// 
/// Separates harakat from text into individual segments.
/// 
/// ```dart
/// import 'package:qcf_quran/qcf_quran.dart';
/// 
/// void main() {
///   final text = 'السَّلاَمُ';
///   final segments = separateHarakat(text);
///   
///   for (var segment in segments) {
///     print('Text: "${segment.text}", Is Harakat: ${segment.isHarakat}');
///   }
///   // Output:
///   // Text: "ا", Is Harakat: false
///   // Text: "ل", Is Harakat: false
///   // Text: "َّ", Is Harakat: true
///   // Text: "ل", Is Harakat: false
///   // ... and so on
/// }
/// ```
/// 
/// ### 2. removeHarakat(String text) → String
/// 
/// Removes all harakat marks from text.
/// 
/// ```dart
/// final text = 'بِسۡمِ ٱللَّهِ';
/// final cleaned = removeHarakat(text);
/// print(cleaned); // بسم الله
/// ```
/// 
/// ### 3. extractHarakat(String text) → String
/// 
/// Extracts only the harakat marks from text.
/// 
/// ```dart
/// final text = 'بِسۡمِ ٱللَّهِ';
/// final harakat = extractHarakat(text);
/// // Returns string containing only harakat marks
/// ```
/// 
/// ### 4. isHarakat(String char) → bool
/// 
/// Checks if a single character is a harakat mark.
/// 
/// ```dart
/// print(isHarakat('َ')); // true
/// print(isHarakat('ا')); // false
/// ```
/// 
/// ### 5. buildHarakatSpans(...) → List<InlineSpan>
/// 
/// Builds text spans for RichText with separate styling for harakat and letters.
/// 
/// ```dart
/// RichText(
///   textDirection: TextDirection.rtl,
///   text: TextSpan(
///     children: buildHarakatSpans(
///       text: 'بِسۡمِ ٱللَّهِ',
///       letterStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
///       letterColor: Colors.black,
///       harakatColor: Colors.red,
///     ),
///   ),
/// )
/// ```
/// 
/// ## Usage Examples
/// 
/// ### Example 1: Simple Text with Colored Harakat
/// 
/// ```dart
/// Widget buildColoredText() {
///   return RichText(
///     textDirection: TextDirection.rtl,
///     text: TextSpan(
///       children: buildHarakatSpans(
///         text: 'السَّلاَمُ عَلَيْكُم',
///         letterColor: Colors.black,
///         harakatColor: Colors.red,
///       ),
///     ),
///   );
/// }
/// ```
/// 
/// ### Example 2: Using with QcfVerse Widget
/// 
/// The QcfVerse widget already has built-in support for harakat coloring:
/// 
/// ```dart
/// QcfVerse(
///   surahNumber: 1,
///   verseNumber: 1,
///   fontSize: 28,
///   textColor: Colors.black,       // Color for base letters
///   tashkeelColor: Colors.red,     // Color for harakat marks
///   sp: 1.sp,
///   h: 1.h,
/// )
/// ```
/// 
/// ### Example 3: Separating and Processing Text
/// 
/// ```dart
/// void processQuranicText(String text) {
///   // Get base letters only
///   final baseText = removeHarakat(text);
///   
///   // Get harakat only
///   final harakatOnly = extractHarakat(text);
///   
///   // Get segments for processing
///   final segments = separateHarakat(text);
///   
///   for (var segment in segments) {
///     if (segment.isHarakat) {
///       print('Harakat mark: "${segment.text}"');
///     } else {
///       print('Letter: "${segment.text}"');
///     }
///   }
/// }
/// ```
/// 
/// ### Example 4: Custom Styling for Harakat
/// 
/// ```dart
/// Widget advancedStyling() {
///   return RichText(
///     textDirection: TextDirection.rtl,
///     text: TextSpan(
///       children: buildHarakatSpans(
///         text: 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ',
///         // Letters styling
///         letterStyle: const TextStyle(
///           fontSize: 24,
///           fontWeight: FontWeight.bold,
///           fontFamily: 'QCF_P001', // QCF font family
///         ),
///         letterColor: Colors.black87,
///         // Harakat styling
///         harakatStyle: const TextStyle(
///           fontSize: 18,
///           fontWeight: FontWeight.normal,
///         ),
///         harakatColor: Colors.red,
///       ),
///     ),
///   );
/// }
/// ```
/// 
/// ### Example 5: Processing Large Quran Dataset
/// 
/// ```dart
/// void processQuranText() {
///   final verseWithHarakat = 'السَّلاَمُ عَلَيْكُم وَرَحْمَةُ الله';
///   
///   // Quick cleanup for storage
///   final cleanText = removeHarakat(verseWithHarakat);
///   
///   // Build UI with colored harakat
///   final spans = buildHarakatSpans(
///     text: verseWithHarakat,
///     letterColor: Colors.black,
///     harakatColor: Colors.red,
///   );
///   
///   // Create RichText widget
///   final widget = RichText(
///     textDirection: TextDirection.rtl,
///     text: TextSpan(children: spans),
///   );
/// }
/// ```
/// 
/// ## Arabic Harakat Range Reference
/// 
/// The module supports these Unicode ranges:
/// 
/// - U+0617..U+061A (ARABIC SMALL FATHA, etc.)
/// - U+064B..U+0652 (ARABIC FATHATAN through ARABIC SUKUN)
/// - U+0670 (ARABIC LETTER SUPERSCRIPT ALEF)
/// - U+06D6..U+06ED (ARABIC SMALL HIGH LIGATURE SAD WITH LAM, etc.)
/// 
/// This covers all standard Arabic diacritical marks used in Quranic text.
/// 
/// ## Performance Considerations
/// 
/// - `separateHarakat()` is O(n) complexity, efficient for large texts
/// - Segments are grouped together (consecutive letters/harakat merged)
/// - Reduces number of TextSpan objects compared to character-by-character styling
/// - Suitable for handling large Quran JSON datasets
/// 
/// ## TextSegment Class
/// 
/// ```dart
/// class TextSegment {
///   final String text;           // The actual text
///   final bool isHarakat;        // Whether it's a harakat mark
///   
///   TextSegment({
///     required this.text,
///     required this.isHarakat,
///   });
/// }
/// ```
/// 
/// ## Tips & Best Practices
/// 
/// 1. **RTL Direction**: Always set `textDirection: TextDirection.rtl` for Arabic text
/// 2. **Font Families**: Combine with QCF fonts for authentic Quran rendering
/// 3. **Color Contrast**: Ensure harakat color has good contrast with letter color
/// 4. **Storage**: Store clean text (without harakat) and render with harakat dynamically
/// 5. **Performance**: Reuse separated segments if rendering the same text multiple times
/// 
/// ## Common Use Cases
/// 
/// - Display Quranic text with colored diacritical marks
/// - Generate clean text for search/indexing
/// - Create educational materials with harakat highlighting
/// - Build Quran visualization tools with custom styling
/// - Support learning resources for Arabic language students
