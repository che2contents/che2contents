class PlanRange {
  final String book; // "창세기" / "출애굽기" / "레위기"
  final int startChapter;
  final int endChapter;

  const PlanRange(this.book, this.startChapter, this.endChapter);
}

class DayPlan {
  final String label;            // 표시용
  final bool isVideo;            // 영상 여부
  final String? videoUrl;        // ✅ 영상 URL
  final List<PlanRange> ranges;  // 읽기 범위

  const DayPlan({
    required this.label,
    required this.isVideo,
    required this.ranges,
    this.videoUrl,
  });

  bool get hasReading => ranges.isNotEmpty;
  bool get hasVideo => isVideo && (videoUrl?.isNotEmpty ?? false);
}

class FebPlan2026 {
  static const Map<String, DayPlan> plan = {
    // ✅ 2/1 영상
    "2026-02-01": DayPlan(
      label: "창세기 1\n영상시청",
      isVideo: true,
      videoUrl: "https://www.youtube.com/watch?v=LLu2xB_rIT4",
      ranges: [PlanRange("창세기", 1, 1)],
    ),

    "2026-02-02": DayPlan(label: "창 1-4", isVideo: false, ranges: [PlanRange("창세기", 1, 4)]),
    "2026-02-03": DayPlan(label: "창 5-8", isVideo: false, ranges: [PlanRange("창세기", 5, 8)]),
    "2026-02-04": DayPlan(label: "창 9-12", isVideo: false, ranges: [PlanRange("창세기", 9, 12)]),
    "2026-02-05": DayPlan(label: "창 13-16", isVideo: false, ranges: [PlanRange("창세기", 13, 16)]),
    "2026-02-06": DayPlan(label: "창 17-20", isVideo: false, ranges: [PlanRange("창세기", 17, 20)]),
    "2026-02-07": DayPlan(label: "창 21-24", isVideo: false, ranges: [PlanRange("창세기", 21, 24)]),

    // ✅ 2/8 영상
    "2026-02-08": DayPlan(
      label: "창세기 2\n영상시청",
      isVideo: true,
      videoUrl: "https://www.youtube.com/watch?v=yUeqd5_MsFY",
      ranges: const [],
    ),

    "2026-02-09": DayPlan(label: "창 25-28", isVideo: false, ranges: [PlanRange("창세기", 25, 28)]),
    "2026-02-10": DayPlan(label: "창 29-32", isVideo: false, ranges: [PlanRange("창세기", 29, 32)]),
    "2026-02-11": DayPlan(label: "창 33-36", isVideo: false, ranges: [PlanRange("창세기", 33, 36)]),
    "2026-02-12": DayPlan(label: "창 37-40", isVideo: false, ranges: [PlanRange("창세기", 37, 40)]),
    "2026-02-13": DayPlan(label: "창 41-45", isVideo: false, ranges: [PlanRange("창세기", 41, 45)]),
    "2026-02-14": DayPlan(label: "창 46-50", isVideo: false, ranges: [PlanRange("창세기", 46, 50)]),

    // ✅ 2/15 영상
    "2026-02-15": DayPlan(
      label: "출애굽기\n영상시청",
      isVideo: true,
      videoUrl: "https://www.youtube.com/watch?v=nuumvEm2D9M",
      ranges: const [],
    ),

    "2026-02-16": DayPlan(label: "출 1-6", isVideo: false, ranges: [PlanRange("출애굽기", 1, 6)]),
    "2026-02-17": DayPlan(label: "출 7-12", isVideo: false, ranges: [PlanRange("출애굽기", 7, 12)]),
    "2026-02-18": DayPlan(label: "출 13-19", isVideo: false, ranges: [PlanRange("출애굽기", 13, 19)]),
    "2026-02-19": DayPlan(label: "출 20-26", isVideo: false, ranges: [PlanRange("출애굽기", 20, 26)]),
    "2026-02-20": DayPlan(label: "출 27-33", isVideo: false, ranges: [PlanRange("출애굽기", 27, 33)]),
    "2026-02-21": DayPlan(label: "출 34-40", isVideo: false, ranges: [PlanRange("출애굽기", 34, 40)]),

    // ✅ 2/22 영상
    "2026-02-22": DayPlan(
      label: "레위기\n영상시청",
      isVideo: true,
      videoUrl: "https://www.youtube.com/watch?v=4Ttqlz3qR8Q",
      ranges: const [],
    ),

    "2026-02-23": DayPlan(label: "레 1-5", isVideo: false, ranges: [PlanRange("레위기", 1, 5)]),
    "2026-02-24": DayPlan(label: "레 6-10", isVideo: false, ranges: [PlanRange("레위기", 6, 10)]),
    "2026-02-25": DayPlan(label: "레 11-15", isVideo: false, ranges: [PlanRange("레위기", 11, 15)]),
    "2026-02-26": DayPlan(label: "레 16-20", isVideo: false, ranges: [PlanRange("레위기", 16, 20)]),
    "2026-02-27": DayPlan(label: "레 21-25", isVideo: false, ranges: [PlanRange("레위기", 21, 25)]),
    "2026-02-28": DayPlan(label: "레 26-27", isVideo: false, ranges: [PlanRange("레위기", 26, 27)]),
  };
}
