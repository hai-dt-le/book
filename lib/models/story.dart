class Chapter {
  final String id;
  final String titleEn;
  final String titleVi;
  final String contentEn;
  final String contentVi;

  Chapter({required this.id, required this.titleEn, required this.titleVi, required this.contentEn, required this.contentVi});

  factory Chapter.fromJson(Map<String, dynamic> j) => Chapter(
    id: j['id'],
    titleEn: j['title_en'] ?? '',
    titleVi: j['title_vi'] ?? '',
    contentEn: j['content_en'] ?? '',
    contentVi: j['content_vi'] ?? '',
  );
}

class Story {
  final String id;
  final String titleEn;
  final String titleVi;
  final List<Chapter> chapters;

  Story({required this.id, required this.titleEn, required this.titleVi, required this.chapters});

  factory Story.fromJson(Map<String, dynamic> j) => Story(
    id: j['id'],
    titleEn: j['title_en'] ?? '',
    titleVi: j['title_vi'] ?? '',
    chapters: (j['chapters'] as List).map((e) => Chapter.fromJson(e)).toList(),
  );
}