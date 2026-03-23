import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/story.dart';

class StoryService {
  static Future<List<Story>> loadStories() async {
    final data = await rootBundle.loadString('assets/stories.json');
    final j = json.decode(data) as List;
    return j.map((e) => Story.fromJson(e)).toList();
  }
}