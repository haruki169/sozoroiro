import 'dart:math';

import '../../core/utils/season.dart';
import '../../data/repositories/theme_repository.dart';
import '../../data/services/location_service.dart';
import '../../data/services/weather_service.dart';
import '../models/daily_theme.dart';
import '../models/theme_catalog_entry.dart';

/// お題選定ロジック（要件定義書4章「季節・天気に連動して出し分け」、design.md 5.3節）。
class ThemeSelector {
  ThemeSelector(
    this._themeRepository,
    this._weatherService,
    this._locationService, {
    Random? random,
  }) : _random = random ?? Random();

  final ThemeRepository _themeRepository;
  final WeatherService _weatherService;
  final LocationService _locationService;
  final Random _random;

  static const int _recentExclusionDays = 7;
  static const int _lowCandidateThreshold = 3;

  /// 指定日（省略時は今日）のお題を取得する。design.md 5.3節の選定手順1〜6を実装。
  ///
  /// [locationFeatureEnabled]は設定画面の位置情報アプリ全体スイッチ。falseの場合、
  /// 天気取得のために座標を一切取得・送信しない（7.1節のプライバシー構造を担保）。
  Future<DailyTheme> getOrCreateTheme({
    DateTime? date,
    bool locationFeatureEnabled = false,
  }) async {
    final targetDate = date ?? DateTime.now();

    // 1. 同日冪等性
    final existing = await _themeRepository.findByDate(targetDate);
    if (existing != null) return existing;

    final season = Season.fromDate(targetDate);
    final allCatalog = await _themeRepository.fetchAllCatalog();
    final recentIds = await _themeRepository.fetchRecentCatalogIds(
      days: _recentExclusionDays,
      asOf: targetDate,
    );

    // 2. 季節タグ絞り込み
    final seasonFiltered = allCatalog
        .where((c) => c.seasonTags.contains(season.tag))
        .toList();

    // 3. 天気タグ絞り込み（位置情報・天気が利用可能な場合のみ）
    String? weatherTag;
    if (locationFeatureEnabled) {
      final position = await _locationService.getCurrentPositionIfEnabled(
        true,
      );
      if (position != null) {
        final condition = await _weatherService.fetchCurrentCondition(
          lat: position.latitude,
          lng: position.longitude,
        );
        weatherTag = condition?.tag;
      }
    }

    List<ThemeCatalogEntry> candidates = seasonFiltered;
    if (weatherTag != null) {
      final weatherFiltered = seasonFiltered
          .where((c) => c.weatherTags.contains(weatherTag))
          .toList();
      if (weatherFiltered.length >= _lowCandidateThreshold) {
        candidates = weatherFiltered;
      }
    }

    // 4. 直近7日重複除外の上でランダム選定
    var pool = candidates.where((c) => !recentIds.contains(c.id)).toList();

    // 5. 候補0件なら天気タグを外し季節のみに緩和
    if (pool.isEmpty) {
      pool = seasonFiltered.where((c) => !recentIds.contains(c.id)).toList();
    }

    // 6. それでも0件なら季節タグも外し、カタログ全体から選定
    if (pool.isEmpty) {
      pool = allCatalog.where((c) => !recentIds.contains(c.id)).toList();
    }
    if (pool.isEmpty) {
      pool = allCatalog;
    }

    final selected = pool[_random.nextInt(pool.length)];
    final phrase =
        selected.poeticPhrases[_random.nextInt(selected.poeticPhrases.length)];

    return _themeRepository.insertDailyTheme(
      date: targetDate,
      catalogId: selected.id,
      poeticPhrase: phrase,
    );
  }

  /// 過去のお題一覧（「気になる色をもう一度探す」用）。2週間単位のページネーション。
  Future<ThemePage> fetchPastThemes({int page = 0, int pageSize = 14}) {
    return _themeRepository.fetchPastThemes(page: page, pageSize: pageSize);
  }
}
