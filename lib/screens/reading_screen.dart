import 'package:flutter/material.dart';
import '../services/bible_repository.dart';

class ReadingScreenArgs {
  final String dateKey; // 2026-02-02
  final String label; // "창 1-4"
  final String book; // "창세기"
  final int startChapter;
  final int endChapter;

  ReadingScreenArgs({
    required this.dateKey,
    required this.label,
    required this.book,
    required this.startChapter,
    required this.endChapter,
  });
}

class ReadingScreen extends StatefulWidget {
  final ReadingScreenArgs args;
  const ReadingScreen({super.key, required this.args});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final BibleRepository _repo = BibleRepository();
  final ScrollController _controller = ScrollController();

  Map<String, dynamic>? _bookJson;
  bool _loading = true;
  String? _error;

  late int _chapter;
  bool _atBottom = false;

  @override
  void initState() {
    super.initState();
    _chapter = widget.args.startChapter;

    _controller.addListener(_onScroll);
    _loadBook();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    final max = _controller.position.maxScrollExtent;
    final cur = _controller.position.pixels;

    // ✅ 핵심: 스크롤이 없을 정도로 짧으면(max==0) 이미 끝까지 읽은 것으로 간주
    final atBottom = max == 0 || cur >= max - 24;

    if (atBottom != _atBottom) {
      setState(() => _atBottom = atBottom);
    }
  }

  Future<void> _loadBook() async {
    try {
      final json = await _repo.loadBook(widget.args.book);
      if (!mounted) return;
      setState(() {
        _bookJson = json;
        _loading = false;
      });

      // ✅ 첫 렌더 후에도 maxScrollExtent가 0인지 재판단 필요(웹에서 특히)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _onScroll();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _nextOrFinish() {
    final a = widget.args;

    if (_chapter < a.endChapter) {
      setState(() {
        _chapter++;
        _atBottom = false; // ✅ 다음 장으로 갈 때 버튼 숨김 초기화
      });

      // 스크롤 맨 위로
      if (_controller.hasClients) {
        _controller.jumpTo(0);
      }

      // ✅ 다음 프레임에서 다시 하단 여부 체크(내용이 짧으면 즉시 버튼 다시 표시)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _onScroll();
      });
    } else {
      // ✅ 끝까지 읽음
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.args;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(), // ✅ 좌측 상단 뒤로가기 상시
        title: Text('${a.book} $_chapter장'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(26),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '범위: ${a.label}  (${_chapter - a.startChapter + 1}/${a.endChapter - a.startChapter + 1}장)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_error != null)
              ? Center(child: Text('로드 실패: $_error'))
              : _buildChapter(),
      bottomNavigationBar: _atBottom
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FilledButton(
                  onPressed: _nextOrFinish,
                  child: Text(_chapter < a.endChapter ? '다음 장' : '완료'),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildChapter() {
    final verses = _repo.chapterVerses(_bookJson!, _chapter);

    return ListView(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      children: [
        if (verses.isEmpty)
          const Text('이 장 데이터가 없습니다. (JSON에 해당 장 키가 있는지 확인)')
        else
          ...verses.map(
            (v) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                v,
                style: const TextStyle(fontSize: 16, height: 1.45),
              ),
            ),
          ),
        const SizedBox(height: 120),
      ],
    );
  }
}
