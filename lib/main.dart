import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/story.dart';
import 'screens/home_page.dart';
import 'screens/reader_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class AppState extends ChangeNotifier {
  Locale _locale = Locale('vi');
  double _fontSize = 18.0;
  bool _isDark = false;

  Locale get locale => _locale;
  double get fontSize => _fontSize;
  bool get isDark => _isDark;

  void setLocale(Locale l) {
    _locale = l;
    notifyListeners();
  }

  void setFontSize(double s) {
    _fontSize = s;
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({required this.prefs, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(builder: (context, state, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Book Reader',
          theme: state.isDark ? ThemeData.dark() : ThemeData.light(),
          locale: state.locale,
          supportedLocales: [Locale('en'), Locale('vi')],
          home: HomePage(),
          routes: {
            ReaderPage.routeName: (ctx) => ReaderPage(),
          },
        );
      }),
    );
  }
}