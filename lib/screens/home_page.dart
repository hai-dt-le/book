import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/story.dart';
import '../services/story_service.dart';
import 'reader_page.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Story>> _stories;

  @override
  void initState() {
    super.initState();
    _stories = StoryService.loadStories();
  }

  String t(BuildContext c, {required String en, required String vi}) {
    final locale = Provider.of<AppState>(c, listen: false).locale;
    return locale.languageCode == 'vi' ? vi : en;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context, en: 'Stories', vi: 'Truyện')), 
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'en') state.setLocale(Locale('en'));
              if (v == 'vi') state.setLocale(Locale('vi'));
              if (v == 'theme') state.toggleTheme();
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'vi', child: Text('Tiếng Việt')),
              PopupMenuItem(value: 'theme', child: Text(t(context, en: 'Toggle Theme', vi: 'Đổi giao diện'))),
            ],
          )
        ],
      ),
      body: FutureBuilder<List<Story>>(
        future: _stories,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final stories = snapshot.data!;
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (ctx, i) {
              final s = stories[i];
              final title = state.locale.languageCode == 'vi' ? s.titleVi : s.titleEn;
              return ListTile(
                title: Text(title),
                subtitle: Text('${s.chapters.length} ${t(context, en: 'chapters', vi: 'chương')}'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReaderPage(story: s)));
                },
              );
            },
          );
        },
      ),
    );
  }
}