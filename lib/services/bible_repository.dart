import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BibleRepository {
  /// bookName: "창세기" -> assets/bible/창세기.json
  Future<Map<String, dynamic>> loadBook(String bookName) async {
    final jsonStr = await rootBundle.loadString('assets/bible/$bookName.json');
    final decoded = json.decode(jsonStr);
    if (decoded is Map<String, dynamic>) return decoded;
    throw Exception('Invalid bible json for $bookName');
  }

  /// JSON 구조: { "1": { "1": "...", "2": "..." }, "2": {...} }
  List<String> chapterVerses(Map<String, dynamic> bookJson, int chapter) {
    final chKey = chapter.toString();
    final chObj = bookJson[chKey];
    if (chObj is! Map) return [];

    final entries = chObj.entries.toList()
      ..sort((a, b) => int.parse(a.key.toString()).compareTo(int.parse(b.key.toString())));

    return entries.map((e) => "${e.key}. ${e.value}").toList();
  }
}
