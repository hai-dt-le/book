import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/story.dart';
import '../main.dart';

class ReaderPage extends StatefulWidget {
  static const routeName = '/reader';
  final Story? story;
  const ReaderPage({this.story, Key? key}) : super(key: key);

  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  int _current = 0;
  late SharedPreferences _prefs;
  Set<String> _bookmarks = {};

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((p) {
      _prefs = p;
      final raw = p.getString('bookmarks') ?? '[]';
      setState(() {
        _bookmarks = Set<String>.from(json.decode(raw));
      });
    });
  }

  void _toggleBookmark(String key) {
    setState(() {
      if (_bookmarks.contains(key)) _bookmarks.remove(key);
      else _bookmarks.add(key);
      _prefs.setString('bookmarks', json.encode(_bookmarks.toList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final story = widget.story!;
    final chapter = story.chapters[_current];
    final locale = appState.locale.languageCode;
    final title = locale == 'vi' ? chapter.titleVi : chapter.titleEn;
    final content = locale == 'vi' ? chapter.contentVi : chapter.contentEn;
    final bookmarkKey = '${story.id}@${chapter.id}';

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'vi' ? story.titleVi : story.titleEn),
        actions: [
          IconButton(
            icon: Icon(_bookmarks.contains(bookmarkKey) ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => _toggleBookmark(bookmarkKey),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: TextStyle(fontSize: appState.fontSize + 4, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Expanded(child: SingleChildScrollView(child: Text(content, style: TextStyle(fontSize: appState.fontSize)))),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_current + 1}/${story.chapters.length}'),
                Row(children: [
                  IconButton(icon: Icon(Icons.chevron_left), onPressed: _current > 0 ? () => setState(() => _current--) : null),
                  IconButton(icon: Icon(Icons.chevron_right), onPressed: _current < story.chapters.length - 1 ? () => setState(() => _current++) : null),
                ])
              ],
            ),
            Row(
              children: [
                Text(locale == 'vi' ? 'Cỡ chữ' : 'Font'),
                Expanded(
                  child: Slider(
                    min: 12,
                    max: 30,
                    value: appState.fontSize,
                    onChanged: (v) => appState.setFontSize(v),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}