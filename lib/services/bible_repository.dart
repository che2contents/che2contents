import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BibleRepository {
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

  Future<dynamic> loadBook(String book) async {
    final path = _bookToAsset[book];
    if (path == null) {
      throw Exception('성경 JSON 매핑이 없습니다: $book');
    }

    final raw = await rootBundle.loadString(path);
    return json.decode(raw);
  }

  List<String> chapterVerses(dynamic bookJson, int chapter) {
    final key1 = chapter.toString();
    final key2 = '${chapter}장';

    dynamic node;

    // 1) 최상위가 Map 인 경우
    if (bookJson is Map) {
      node = bookJson[key1] ?? bookJson[key2];

      // chapters 아래에 있는 경우
      if (node == null && bookJson['chapters'] is Map) {
        final chapters = bookJson['chapters'] as Map;
        node = chapters[key1] ?? chapters[key2];
      }

      // 장/본문 같은 다른 키 구조 탐색
      if (node == null && bookJson['장'] is Map) {
        final chapters = bookJson['장'] as Map;
        node = chapters[key1] ?? chapters[key2];
      }
    }

    // 2) 최상위가 List 인 경우
    if (node == null && bookJson is List) {
      for (final item in bookJson) {
        if (item is Map) {
          final c = item['chapter'] ?? item['장'];
          if (c.toString() == key1) {
            node = item['verses'] ?? item['본문'] ?? item;
            break;
          }
        }
      }
    }

    if (node == null) return const [];

    // A. ["절1", "절2"] 형태
    if (node is List) {
      return node.map((e) => e.toString()).toList();
    }

    // B. {"1":"...", "2":"..."} 형태
    if (node is Map) {
      if (node['verses'] is List) {
        return (node['verses'] as List).map((e) => e.toString()).toList();
      }

      if (node['본문'] is List) {
        return (node['본문'] as List).map((e) => e.toString()).toList();
      }

      // 절 번호를 key로 갖는 경우 정렬해서 반환
      final entries = node.entries.toList()
        ..sort((a, b) {
          final ai = int.tryParse(a.key.toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
          final bi = int.tryParse(b.key.toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
          return ai.compareTo(bi);
        });

      return entries.map((e) => e.value.toString()).toList();
    }

    // C. 그냥 문자열 하나인 경우
    return [node.toString()];
  }
}
