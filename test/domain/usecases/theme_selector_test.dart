import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sozoroiro/core/utils/season.dart';
import 'package:sozoroiro/data/db/app_database.dart';
import 'package:sozoroiro/data/repositories/theme_repository.dart';
import 'package:sozoroiro/data/services/location_service.dart';
import 'package:sozoroiro/data/services/weather_service.dart';
import 'package:sozoroiro/domain/usecases/theme_selector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ThemeRepository themeRepository;
  late ThemeSelector selector;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    themeRepository = ThemeRepository(db);
    await themeRepository.seedCatalogIfEmpty();
    selector = ThemeSelector(
      themeRepository,
      WeatherService(),
      LocationService(),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('同一日に複数回呼んでも同じDailyThemeが返る（冪等性）', () async {
    final date = DateTime(2026, 6, 15);
    final first = await selector.getOrCreateTheme(date: date);
    final second = await selector.getOrCreateTheme(date: date);

    expect(second.id, first.id);
    expect(second.catalog.id, first.catalog.id);
  });

  test('季節タグに応じた絞り込みが行われる（天気情報なし=位置情報OFF時）', () async {
    final date = DateTime(2026, 7, 20); // 夏
    final theme = await selector.getOrCreateTheme(date: date);

    expect(theme.catalog.seasonTags, contains(Season.summer.tag));
  });

  test('直近7日間に選定済みのcatalogIdが再選定されない', () async {
    final selectedCatalogIds = <int>{};
    for (var i = 0; i < 6; i++) {
      final date = DateTime(2026, 8, 1 + i); // 夏、候補15件中6件を消費
      final theme = await selector.getOrCreateTheme(date: date);
      expect(selectedCatalogIds.contains(theme.catalog.id), isFalse);
      selectedCatalogIds.add(theme.catalog.id);
    }
  });

  test('位置情報機能OFF時は天気タグ絞り込みを行わず季節のみで選定する', () async {
    final date = DateTime(2026, 1, 10); // 冬
    final theme = await selector.getOrCreateTheme(
      date: date,
      locationFeatureEnabled: false,
    );

    expect(theme.catalog.seasonTags, contains(Season.winter.tag));
  });

  test('fetchPastThemesは2週間単位のページネーションで返す', () async {
    for (var i = 0; i < 20; i++) {
      await selector.getOrCreateTheme(date: DateTime(2026, 1, 1 + i));
    }

    final page0 = await selector.fetchPastThemes(page: 0, pageSize: 14);
    expect(page0.items.length, 14);
    expect(page0.hasMore, isTrue);

    final page1 = await selector.fetchPastThemes(page: 1, pageSize: 14);
    expect(page1.items.length, 6);
    expect(page1.hasMore, isFalse);
  });
}
