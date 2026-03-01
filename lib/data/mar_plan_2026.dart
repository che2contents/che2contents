// lib/data/mar_plan_2026.dart

class DayPlan {
  final String label;
  final List<ReadingRange> ranges;
  final String? videoUrl;

  DayPlan({
    required this.label,
    required this.ranges,
    this.videoUrl,
  });

  bool get hasReading => ranges.isNotEmpty;
  bool get hasVideo => videoUrl != null && videoUrl!.trim().isNotEmpty;
}

class ReadingRange {
  final String book;
  final int startChapter;
  final int endChapter;

  ReadingRange({
    required this.book,
    required this.startChapter,
    required this.endChapter,
  });
}

class MarPlan2026 {
  static final Map<String, DayPlan> plan = {

    // ======================
    // 🔴 1주차
    // ======================
    "2026-03-01": DayPlan(
      label: "민수기\n영상시청",
      ranges: [],
      videoUrl:
          "https://www.youtube.com/watch?v=ODkCppuCsAA&list=PL68UlTaS5lt_sSPn82QlThS3zDY-JrbRR&index=6",
    ),

    "2026-03-02": DayPlan(
      label: "민 1-6",
      ranges: [ReadingRange(book: "민수기", startChapter: 1, endChapter: 6)],
    ),
    "2026-03-03": DayPlan(
      label: "민 7-12",
      ranges: [ReadingRange(book: "민수기", startChapter: 7, endChapter: 12)],
    ),
    "2026-03-04": DayPlan(
      label: "민 13-18",
      ranges: [ReadingRange(book: "민수기", startChapter: 13, endChapter: 18)],
    ),
    "2026-03-05": DayPlan(
      label: "민 19-24",
      ranges: [ReadingRange(book: "민수기", startChapter: 19, endChapter: 24)],
    ),
    "2026-03-06": DayPlan(
      label: "민 25-30",
      ranges: [ReadingRange(book: "민수기", startChapter: 25, endChapter: 30)],
    ),
    "2026-03-07": DayPlan(
      label: "민 31-36",
      ranges: [ReadingRange(book: "민수기", startChapter: 31, endChapter: 36)],
    ),

    // ======================
    // 🔴 2주차
    // ======================
    "2026-03-08": DayPlan(
      label: "신명기\n영상시청",
      ranges: [],
      videoUrl:
          "https://www.youtube.com/watch?v=nrGJvJz9WHI&list=PL68UlTaS5lt_sSPn82QlThS3zDY-JrbRR&index=7",
    ),
    "2026-03-09": DayPlan(
      label: "신 1-6",
      ranges: [ReadingRange(book: "신명기", startChapter: 1, endChapter: 6)],
    ),
    "2026-03-10": DayPlan(
      label: "신 7-12",
      ranges: [ReadingRange(book: "신명기", startChapter: 7, endChapter: 12)],
    ),
    "2026-03-11": DayPlan(
      label: "신 13-18",
      ranges: [ReadingRange(book: "신명기", startChapter: 13, endChapter: 18)],
    ),
    "2026-03-12": DayPlan(
      label: "신 19-24",
      ranges: [ReadingRange(book: "신명기", startChapter: 19, endChapter: 24)],
    ),
    "2026-03-13": DayPlan(
      label: "신 25-29",
      ranges: [ReadingRange(book: "신명기", startChapter: 25, endChapter: 29)],
    ),
    "2026-03-14": DayPlan(
      label: "신 30-34",
      ranges: [ReadingRange(book: "신명기", startChapter: 30, endChapter: 34)],
    ),

    // ======================
    // 🔴 3주차
    // ======================
    "2026-03-15": DayPlan(
      label: "여호수아\n영상시청",
      ranges: [],
      videoUrl:
          "https://www.youtube.com/watch?v=Eb6jCXeDHCg&list=PL68UlTaS5lt_sSPn82QlThS3zDY-JrbRR&index=8",
    ),
    "2026-03-16": DayPlan(
      label: "수 1-4",
      ranges: [ReadingRange(book: "여호수아", startChapter: 1, endChapter: 4)],
    ),
    "2026-03-17": DayPlan(
      label: "수 5-8",
      ranges: [ReadingRange(book: "여호수아", startChapter: 5, endChapter: 8)],
    ),
    "2026-03-18": DayPlan(
      label: "수 9-12",
      ranges: [ReadingRange(book: "여호수아", startChapter: 9, endChapter: 12)],
    ),
    "2026-03-19": DayPlan(
      label: "수 13-16",
      ranges: [ReadingRange(book: "여호수아", startChapter: 13, endChapter: 16)],
    ),
    "2026-03-20": DayPlan(
      label: "수 17-20",
      ranges: [ReadingRange(book: "여호수아", startChapter: 17, endChapter: 20)],
    ),
    "2026-03-21": DayPlan(
      label: "수 21-24",
      ranges: [ReadingRange(book: "여호수아", startChapter: 21, endChapter: 24)],
    ),

    // ======================
    // 🔴 4주차
    // ======================
    "2026-03-22": DayPlan(
      label: "사사기\n영상시청",
      ranges: [],
      videoUrl:
          "https://www.youtube.com/watch?v=A4BVjXOnJXY&list=PL68UlTaS5lt9L2bTJ2MgN2q9yeniRGfDJ",
    ),
    "2026-03-23": DayPlan(
      label: "삿 1-4",
      ranges: [ReadingRange(book: "사사기", startChapter: 1, endChapter: 4)],
    ),
    "2026-03-24": DayPlan(
      label: "삿 5-8",
      ranges: [ReadingRange(book: "사사기", startChapter: 5, endChapter: 8)],
    ),
    "2026-03-25": DayPlan(
      label: "삿 9-12",
      ranges: [ReadingRange(book: "사사기", startChapter: 9, endChapter: 12)],
    ),
    "2026-03-26": DayPlan(
      label: "삿 13-16",
      ranges: [ReadingRange(book: "사사기", startChapter: 13, endChapter: 16)],
    ),
    "2026-03-27": DayPlan(
      label: "삿 17-21",
      ranges: [ReadingRange(book: "사사기", startChapter: 17, endChapter: 21)],
    ),
    "2026-03-28": DayPlan(
      label: "룻 1-4",
      ranges: [ReadingRange(book: "룻기", startChapter: 1, endChapter: 4)],
    ),

    // ======================
    // 🔴 5주차
    // ======================
    "2026-03-29": DayPlan(
      label: "사무엘상\n영상시청",
      ranges: [],
      videoUrl:
          "https://www.youtube.com/watch?v=YLuWUTeCltc&list=PL68UlTaS5lt9L2bTJ2MgN2q9yeniRGfDJ&index=2",
    ),
    "2026-03-30": DayPlan(
      label: "삼상 1-5",
      ranges: [ReadingRange(book: "사무엘상", startChapter: 1, endChapter: 5)],
    ),
    "2026-03-31": DayPlan(
      label: "삼상 6-10",
      ranges: [ReadingRange(book: "사무엘상", startChapter: 6, endChapter: 10)],
    ),
  };
}