# Harakat Separator - Quick Reference Card

## 🎯 Three Ways to Use

### 1️⃣ Easiest (Widget)
```dart
HarakatTextDisplay(
  text: 'السَّلاَمُ',
  letterColor: Colors.black,
  harakatColor: Colors.red,
  fontSize: 20,
)
```
✅ Simple | ✅ Quick | ⚠️ Less control

---

### 2️⃣ Medium (Spans + RichText)
```dart
RichText(
  textDirection: TextDirection.rtl,
  text: TextSpan(
    children: buildHarakatSpans(
      'السَّلاَمُ',
      letterColor: Colors.black,
      harakatColor: Colors.red,
    ),
  ),
)
```
✅ More control | ✅ Flexible | ⚠️ More code

---

### 3️⃣ Hardest (Low-level)
```dart
final segments = separateHarakat('السَّلاَمُ');
for (var seg in segments) {
  if (seg.isHarakat) {
    // Render in red
  } else {
    // Render in black
  }
}
```
✅ Full control | ⚠️ Most code | ⚠️ Manual rendering

---

## 🛠️ Function Cheat Sheet

| Need | Function | Returns |
|------|----------|---------|
| Separate text | `separateHarakat(text)` | `List<TextSegment>` |
| Clean text | `removeHarakat(text)` | `String` |
| Just marks | `extractHarakat(text)` | `String` |
| Is harakat? | `isHarakat(char)` | `bool` |
| Styled spans | `buildHarakatSpans(...)` | `List<InlineSpan>` |

---

## 🎨 Widget Options

### HarakatTextDisplay
```dart
HarakatTextDisplay(
  text: 'النص',
  letterColor: Colors.black,
  harakatColor: Colors.red,
  fontSize: 20,
  harakatFontSize: 16,  // Optional
  lineHeightMultiplier: 1.5,
)
```

### HarakatAnalysisCard
```dart
HarakatAnalysisCard(
  text: 'النص',
  title: 'Analysis',
  backgroundColor: Colors.white,
)
```

### HarakatComparisonWidget
```dart
HarakatComparisonWidget(
  textWithHarakat: 'السَّلاَمُ',
  title: 'Comparison',
)
```

---

## 📊 Common Patterns

### Pattern 1: Color Different Harakat
```dart
buildHarakatSpans(
  text,
  letterColor: Colors.black,      // Letters
  harakatColor: Colors.red,       // Standard harakat
)
```

### Pattern 2: With QCF Font
```dart
QcfVerse(
  surahNumber: 1,
  verseNumber: 1,
  textColor: Colors.black,        // Letters
  tashkeelColor: Colors.red,      // Harakat
)
```

### Pattern 3: Storage + Display
```dart
// Store clean
final clean = removeHarakat(original);
database.save(clean);

// Display with harakat
final display = buildHarakatSpans(original, ...);
```

### Pattern 4: Search Index
```dart
// For search, remove harakat
final searchText = removeHarakat(verse['content']);
if (searchText.contains(query)) {
  // Display original with harakat
}
```

---

## 🎭 Real Examples

### Example 1: Bismillah
```dart
HarakatTextDisplay(
  text: 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
  letterColor: Colors.black87,
  harakatColor: Colors.red,
  fontSize: 24,
)
```

### Example 2: Ayat al-Kursi
```dart
QcfVerse(
  surahNumber: 2,
  verseNumber: 255,
  fontSize: 22,
  tashkeelColor: Colors.red,
  textColor: Colors.black,
  sp: 1.sp,
  h: 1.h,
)
```

### Example 3: Educational Card
```dart
HarakatAnalysisCard(
  text: 'السَّلاَمُ عَلَيْكُم',
  title: 'Learn Harakat',
)
```

---

## ⚡ Performance Tips

| Tip | Benefit |
|-----|---------|
| Cache `separateHarakat()` results | Avoid re-processing |
| Store clean text in DB | Faster search/index |
| Use `HarakatTextDisplay` | Optimized internally |
| Lazy load verses | Reduce initial load |
| Batch processing | Better efficiency |

Example:
```dart
// Cache segments
final cache = <String, List<TextSegment>>{};

List<TextSegment> getCached(String text) {
  return cache.putIfAbsent(text, () => separateHarakat(text));
}
```

---

## 🔤 Harakat Reference

| Mark | Name | Example |
|------|------|---------|
| َ | Fatha | أَ |
| ُ | Damma | أُ |
| ِ | Kasra | أِ |
| ْ | Sukun | أْ |
| ّ | Shadda | أّ |
| ً | Fathantan | أً |
| ٌ | Dammatan | أٌ |
| ٍ | Kasratan | أٍ |

---

## ✅ Checklist for Integration

- [ ] Import `harakat_separator` or `harakat_widgets`
- [ ] Choose your approach (widget/function/spans)
- [ ] Set `textDirection: TextDirection.rtl`
- [ ] Choose colors (letters vs harakat)
- [ ] Test with your text
- [ ] Optimize if needed
- [ ] Cache results if rendering repeatedly

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Text not showing | Set `textDirection: TextDirection.rtl` |
| Colors not visible | Check contrast between colors |
| Harakat missing | Ensure input text has harakat marks |
| Performance slow | Cache segments, use HarakatTextDisplay |
| No color change | Use `tashkeelColor` in QcfVerse |

---

## 📦 All Exports

```dart
// From qcf_quran package
import 'package:qcf_quran/qcf_quran.dart';

// Available:
- separateHarakat()
- removeHarakat()
- extractHarakat()
- isHarakat()
- buildHarakatSpans()
- HarakatTextDisplay
- HarakatAnalysisCard
- HarakatComparisonWidget
- TextSegment (class)
```

---

## 🚀 Get Started Now

**Minimum code to get started:**

```dart
// Copy-paste ready
HarakatTextDisplay(
  text: 'بِسۡمِ ٱللَّهِ',
  letterColor: Colors.black,
  harakatColor: Colors.red,
  fontSize: 20,
)
```

That's it! Run and see harakat highlighted in red! 🎉

---

## 📚 Learn More

- 📖 `README_HARAKAT.md` - Detailed guide
- 📝 `HARAKAT_SEPARATOR_GUIDE.md` - Technical docs
- 💻 `harakat_separator_example_page.dart` - 8 examples
- 🎓 Example project - Interactive demos

---

## 💬 Common Questions

**Q: Will this work with my custom fonts?**
A: Yes! Use `fontFamily` parameter in HarakatTextDisplay

**Q: Can I change only harakat size?**
A: Yes! Use `harakatFontSize` in HarakatTextDisplay

**Q: Do I need QCF fonts?**
A: No, works with any font. QCF optional for Quran

**Q: Is it RTL by default?**
A: Use RichText with `textDirection: TextDirection.rtl`

**Q: Can I use gestures?**
A: Yes, `buildHarakatSpans` supports `recognizer` parameter

---

Made with ❤️ for Quranic text rendering
