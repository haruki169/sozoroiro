import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sozoroiro/data/db/app_database.dart';
import 'package:sozoroiro/data/repositories/entry_repository.dart';
import 'package:sozoroiro/data/repositories/theme_repository.dart';
import 'package:sozoroiro/data/services/export_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ThemeRepository themeRepository;
  late EntryRepository entryRepository;
  late ExportService exportService;
  late Directory tempDir;
  late File photoFile;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    themeRepository = ThemeRepository(db);
    entryRepository = EntryRepository(db);
    exportService = ExportService(entryRepository, themeRepository);
    tempDir = Directory.systemTemp.createTempSync('export_service_test');
    photoFile = File('${tempDir.path}/photo.jpg')
      ..writeAsBytesSync([0xFF, 0xD8, 0xFF]);
  });

  tearDown(() async {
    await db.close();
    tempDir.deleteSync(recursive: true);
  });

  test('エクスポートアーカイブにJSON(entries・dailyThemes)と写真が含まれる', () async {
    final catalogId = await db.themeDao.insertCatalogEntry(
      ThemeCatalogCompanion.insert(
        catalogKey: 'export-test',
        name: '曇り空の下の緑',
        colorHex: '#5C7A5E',
        seasonTagsJson: '[]',
        weatherTagsJson: '[]',
        poeticPhrasesJson: '["テスト"]',
      ),
    );
    final theme = await themeRepository.insertDailyTheme(
      date: DateTime(2026, 8, 18),
      catalogId: catalogId,
      poeticPhrase: 'テスト',
    );
    await entryRepository.createEntry(
      photo: photoFile,
      extractedColorHex: '#5C7A5E',
      dailyThemeId: theme.id,
      memo: 'メモ',
      locationRecorded: false,
    );

    final outputDir = Directory('${tempDir.path}/out')..createSync();
    final zipFile = await exportService.buildArchive(outputDir);

    expect(zipFile.existsSync(), isTrue);

    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    final entriesJsonFile = archive.findFile('entries.json');
    expect(entriesJsonFile, isNotNull);
    final decoded =
        jsonDecode(utf8.decode(entriesJsonFile!.content as List<int>))
            as Map<String, dynamic>;
    expect((decoded['entries'] as List).length, 1);
    expect((decoded['dailyThemes'] as List).length, 1);
    expect(decoded['entries'][0]['memo'], 'メモ');

    expect(archive.findFile('photos/photo.jpg'), isNotNull);
  });

  test('論理削除済みのエントリはエクスポート対象から除外される', () async {
    final catalogId = await db.themeDao.insertCatalogEntry(
      ThemeCatalogCompanion.insert(
        catalogKey: 'export-test-2',
        name: '雪明かりの色',
        colorHex: '#E7EEF2',
        seasonTagsJson: '[]',
        weatherTagsJson: '[]',
        poeticPhrasesJson: '["テスト"]',
      ),
    );
    final theme = await themeRepository.insertDailyTheme(
      date: DateTime(2026, 1, 1),
      catalogId: catalogId,
      poeticPhrase: 'テスト',
    );
    final entryId = await entryRepository.createEntry(
      photo: photoFile,
      extractedColorHex: '#E7EEF2',
      dailyThemeId: theme.id,
      locationRecorded: false,
    );
    await entryRepository.softDelete(entryId);

    final outputDir = Directory('${tempDir.path}/out2')..createSync();
    final zipFile = await exportService.buildArchive(outputDir);
    final archive = ZipDecoder().decodeBytes(await zipFile.readAsBytes());
    final decoded =
        jsonDecode(
              utf8.decode(
                archive.findFile('entries.json')!.content as List<int>,
              ),
            )
            as Map<String, dynamic>;

    expect((decoded['entries'] as List), isEmpty);
  });
}
