# Flutter Reader Skeleton

This branch contains a minimal Flutter skeleton for a bilingual (English/Vietnamese) story reader.

Features:
- Home: list stories from assets/stories.json
- Reader: read chapters, change font size, simple bookmark per chapter (saved to SharedPreferences)
- Language toggle (EN/VI) and theme toggle

How to run:
1. Ensure Flutter SDK installed (stable channel)
2. Checkout branch feature/flutter-reader
3. Run:
```
flutter pub get
flutter run
```

Notes:
- This is a starting point. EPUB support, syncing, and more advanced localization (ARB -> generated code) can be added later.
