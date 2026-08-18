import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sozoroiro/data/db/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('theme_catalog: insert then select', () async {
    final id = await db.themeDao.insertCatalogEntry(
      ThemeCatalogCompanion.insert(
        catalogKey: 'test-key',
        name: '雨上がりのアスファルトの色',
        colorHex: '#7A7A7A',
        seasonTagsJson: '["spring"]',
        weatherTagsJson: '["rain"]',
        poeticPhrasesJson: '["静かな午後に"]',
      ),
    );

    final all = await db.themeDao.fetchAllCatalog();
    expect(all.length, 1);
    expect(all.first.id, id);
    expect(all.first.name, '雨上がりのアスファルトの色');
  });

  test('daily_themes + entries: insert then select via join', () async {
    final catalogId = await db.themeDao.insertCatalogEntry(
      ThemeCatalogCompanion.insert(
        catalogKey: 'test-key-2',
        name: '陽だまりの色',
        colorHex: '#F5C16C',
        seasonTagsJson: '[]',
        weatherTagsJson: '["sunny"]',
        poeticPhrasesJson: '["まぶしい日に"]',
      ),
    );

    final today = DateTime(2026, 1, 1);
    final dailyThemeId = await db.themeDao.insertDailyTheme(
      DailyThemesCompanion.insert(
        date: today,
        catalogId: catalogId,
        poeticPhrase: 'まぶしい日に',
      ),
    );

    await db.entryDao.insertEntry(
      EntriesCompanion.insert(
        recordedAt: today,
        photoPath: '/tmp/photo.jpg',
        extractedColorHex: '#F5C16C',
        dailyThemeId: dailyThemeId,
        locationRecorded: const Value(false),
      ),
    );

    final timeline = await db.entryDao.watchTimeline().first;
    expect(timeline.length, 1);
    expect(timeline.first.catalog.name, '陽だまりの色');
    expect(timeline.first.dailyTheme.id, dailyThemeId);
  });

  test('settings: watch creates default row and updates persist', () async {
    final initial = await db.settingsDao.watchSettings().first;
    expect(initial.notificationFrequency, 'occasionally');

    await db.settingsDao.updateSettings(
      const SettingsCompanion(notificationEnabled: Value(false)),
    );

    final updated = await db.settingsDao.watchSettings().first;
    expect(updated.notificationEnabled, false);
  });

  test('soft delete excludes rows from deletedAt IS NULL queries', () async {
    final catalogId = await db.themeDao.insertCatalogEntry(
      ThemeCatalogCompanion.insert(
        catalogKey: 'test-key-3',
        name: '曇り空の下の緑',
        colorHex: '#6B8E6B',
        seasonTagsJson: '[]',
        weatherTagsJson: '["cloudy"]',
        poeticPhrasesJson: '["静かに"]',
      ),
    );
    final dailyThemeId = await db.themeDao.insertDailyTheme(
      DailyThemesCompanion.insert(
        date: DateTime(2026, 2, 1),
        catalogId: catalogId,
        poeticPhrase: '静かに',
      ),
    );

    await db.themeDao.softDeleteDailyTheme(dailyThemeId);

    final page = await db.themeDao.fetchPastThemesPage(page: 0, pageSize: 14);
    expect(page.any((t) => t.id == dailyThemeId), isFalse);
  });
}
