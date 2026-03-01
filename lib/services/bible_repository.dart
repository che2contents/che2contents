import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BibleRepository {
  // assets/bible 아래 파일명에 맞게 추가/수정
  static const Map<String, String> _bookToAsset = {
    "창세기": "assets/bible/창세기.json",
    "출애굽기": "assets/bible/출애굽기.json",
    "레위기": "assets/bible/레위기.json",
    "민수기": "assets/bible/민수기.json",
    "신명기": "assets/bible/신명기.json",
    "여호수아": "assets/bible/여호수아.json",
    "사사기": "assets/bible/사사기.json",
    "룻기": "assets/bible/룻기.json",
    "사무엘상": "assets/bible/사무엘상.json",
  };

  Future<Map<String, dynamic>> loadBook(String book) async {
    final path = _bookToAsset[book];
    if (path == null) {
      throw Exception('성경 JSON 매핑이 없습니다: $book');
    }

    final raw = await rootBundle.loadString(path);
    final jsonMap = json.decode(raw);
    if (jsonMap is! Map<String, dynamic>) {
      throw Exception('JSON 형식이 올바르지 않습니다: $path');
    }
    return jsonMap;
  }

  /// chapterVerses는 JSON 구조에 따라 조정이 필요할 수 있음.
  /// 현재는 "chapters" 또는 "장" 같은 키를 기대하지 않고
  /// 1) json[chapter.toString()] 형태
  /// 2) json["chapters"][chapter.toString()] 형태
  /// 둘 다 시도함.
  List<String> chapterVerses(Map<String, dynamic> bookJson, int chapter) {
    final key = chapter.toString();

    dynamic node = bookJson[key];
    node ??= (bookJson["chapters"] is Map ? (bookJson["chapters"] as Map)[key] : null);

    if (node == null) return const [];

    // node가 List면 바로 verses
    if (node is List) {
      return node.map((e) => e.toString()).toList();
    }

    // node가 Map이면 "verses" 키 우선
    if (node is Map) {
      final verses = node["verses"];
      if (verses is List) {
        return verses.map((e) => e.toString()).toList();
      }
    }

    return const [];
  }
}