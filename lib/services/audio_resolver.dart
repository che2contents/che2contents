class AudioResolver {
  // ✅ 책 이름 → 파일 prefix
  static const Map<String, String> _bookToPrefix = {
    "민수기": "num",
    "신명기": "deu",
    "여호수아": "jos",
    "사사기": "jdg",
    "룻기": "rut",
    "사무엘상": "1sa",
  };

  // ✅ (책, startChapter) → part번호(1부터 시작)
  // 3월 플랜(이미지) 기준 100% 매칭
  static const Map<String, Map<int, int>> _startToPart = {
    "민수기": {
      1: 1,
      7: 2,
      13: 3,
      19: 4,
      25: 5,
      31: 6,
    },
    "신명기": {
      1: 1,
      7: 2,
      13: 3,
      19: 4,
      25: 5,
      30: 6,
    },
    "여호수아": {
      1: 1,
      5: 2,
      9: 3,
      13: 4,
      17: 5,
      21: 6,
    },
    "사사기": {
      1: 1,
      5: 2,
      9: 3,
      13: 4,
      17: 5,
    },
    "룻기": {
      1: 1,
    },
    "사무엘상": {
      1: 1,
      6: 2,
    },
  };

  /// ✅ 반환: audioplayers AssetSource에 넣을 상대경로
  /// 예: "audio/num001.mp3"
  static String? forRange({
    required String book,
    required int startChapter,
    required int endChapter,
    String ext = "mp3",
  }) {
    final prefix = _bookToPrefix[book];
    if (prefix == null) return null;

    final part = _startToPart[book]?[startChapter];
    if (part == null) return null;

    final p = part.toString().padLeft(3, '0');
    return "audio/$prefix$p.$ext";
  }
}