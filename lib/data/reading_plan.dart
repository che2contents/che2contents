// lib/data/reading_plan.dart
class ReadingPlan {
  /// 날짜 -> 표시할 문구
  /// (추후 서버/업로드로 확장 가능하도록 분리)
  static final Map<String, String> planByDateKey = {
    "02-01": "Youtube시청",
    "02-02": "창세기 1-4장",
    "02-03": "창세기 5-8장",
    "02-04": "창세기 9-12장",
  };

  /// DateTime -> yyyy-MM-dd 키 변환
  static String toKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return "$y-$m-$day";
  }

  static String? getTask(DateTime d) => planByDateKey[toKey(d)];
}
