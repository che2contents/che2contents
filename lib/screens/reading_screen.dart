import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../services/bible_repository.dart';

class ReadingScreenArgs {
  final String dateKey;
  final String label;
  final String book;
  final int startChapter;
  final int endChapter;
  final String? audioAsset; // "audio/xxx.mp3"

  ReadingScreenArgs({
    required this.dateKey,
    required this.label,
    required this.book,
    required this.startChapter,
    required this.endChapter,
    this.audioAsset,
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

  late final AudioPlayer _player;
  bool _isPlaying = false;

  static const List<double> _fontSteps = [1.2, 1.5, 2.0];
  double _fontScale = 1.2;

  Map<String, dynamic>? _bookJson;
  bool _loading = true;
  String? _error;

  late int _chapter;
  bool _atBottom = false;

  @override
  void initState() {
    super.initState();
    _chapter = widget.args.startChapter;

    _player = AudioPlayer();
    _player.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() => _isPlaying = false);
    });

    _controller.addListener(_onScroll);
    _loadBook();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final max = _controller.position.maxScrollExtent;
    final cur = _controller.position.pixels;

    final atBottom = max == 0 || cur >= max - 24;
    if (atBottom != _atBottom) setState(() => _atBottom = atBottom);
  }

  Future<void> _loadBook() async {
    try {
      final json = await _repo.loadBook(widget.args.book);
      if (!mounted) return;
      setState(() {
        _bookJson = json;
        _loading = false;
      });

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
        _atBottom = false;
      });

      if (_controller.hasClients) _controller.jumpTo(0);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _onScroll();
      });
    } else {
      Navigator.pop(context, true);
    }
  }

  void _prevChapter() {
    final a = widget.args;
    if (_chapter <= a.startChapter) return;

    setState(() {
      _chapter--;
      _atBottom = false;
    });

    if (_controller.hasClients) _controller.jumpTo(0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _onScroll();
    });
  }

  Future<void> _togglePlay() async {
    final asset = widget.args.audioAsset;

    if (asset == null || asset.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('해당 진도의 오디오가 없습니다.')),
      );
      return;
    }

    final src = asset.startsWith('assets/') ? asset.replaceFirst('assets/', '') : asset;

    try {
      if (_isPlaying) {
        await _player.pause();
        if (!mounted) return;
        setState(() => _isPlaying = false);
      } else {
        debugPrint("PLAYING_ASSET=$src");
        await _player.play(AssetSource(src));
        if (!mounted) return;
        setState(() => _isPlaying = true);
      }
    } catch (e) {
      debugPrint("PLAY_ERROR=$e");
      if (!mounted) return;
      setState(() => _isPlaying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('오디오 재생에 실패했습니다.')),
      );
    }
  }

  void _zoomOut() {
    final idx = _fontSteps.indexOf(_fontScale);
    if (idx > 0) setState(() => _fontScale = _fontSteps[idx - 1]);
  }

  void _zoomIn() {
    final idx = _fontSteps.indexOf(_fontScale);
    if (idx >= 0 && idx < _fontSteps.length - 1) {
      setState(() => _fontScale = _fontSteps[idx + 1]);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.args;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('${a.book} $_chapter장'),
        actions: [
          IconButton(
            onPressed: (a.audioAsset == null || a.audioAsset!.trim().isEmpty) ? null : _togglePlay,
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            tooltip: _isPlaying ? '일시정지' : '재생',
          ),
          IconButton(
            onPressed: _zoomOut,
            icon: const Icon(Icons.text_decrease),
            tooltip: '글씨 작게',
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('${_fontScale}x'),
            ),
          ),
          IconButton(
            onPressed: _zoomIn,
            icon: const Icon(Icons.text_increase),
            tooltip: '글씨 크게',
          ),
          const SizedBox(width: 6),
        ],
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
              : _buildChapterScaled(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _chapter > a.startChapter ? _prevChapter : null,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('이전 장'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _atBottom ? _nextOrFinish : null,
                  icon: Icon(_chapter < a.endChapter ? Icons.chevron_right : Icons.check),
                  label: Text(_chapter < a.endChapter ? '다음 장' : '완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapterScaled() {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(_fontScale),
      ),
      child: _buildChapter(),
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