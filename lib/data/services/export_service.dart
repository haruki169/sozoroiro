import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/models/daily_theme.dart';
import '../repositories/entry_repository.dart';
import '../repositories/theme_repository.dart';

/// データエクスポート（要件5.5、JSON+画像をまとめてOS共有シートへ、サイズ上限なし・確定）。
class ExportService {
  ExportService(this._entryRepository, this._themeRepository);

  final EntryRepository _entryRepository;
  final ThemeRepository _themeRepository;

  /// 全entries・daily_themesをJSON化し、参照する画像ファイルとともにアーカイブを作成し、
  /// share_plusでOS標準の共有シートを開く。論理削除済み（deletedAt != null）のレコードは含めない。
  Future<void> exportAndShare() async {
    final tempDir = await getTemporaryDirectory();
    final zipFile = await buildArchive(tempDir);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(zipFile.path)],
        text: 'そぞろいろ の記録データ',
      ),
    );
  }

  /// エクスポートアーカイブ（zip）を[outputDir]配下に作成し、そのFileを返す。
  /// share_plus呼び出しを含まないため単体テスト可能。
  Future<File> buildArchive(Directory outputDir) async {
    // watchTimeline()はdeletedAt IS NULLのみを対象にしたStream（entry_dao参照）。
    final entries = await _entryRepository.watchTimeline().first;
    final dailyThemes = await _fetchAllDailyThemes();

    final dailyThemesJson = dailyThemes
        .map(
          (t) => {
            'date': t.date.toIso8601String(),
            'themeName': t.catalog.name,
            'colorHex': t.catalog.colorHex,
            'poeticPhrase': t.poeticPhrase,
          },
        )
        .toList();

    final entriesJson = entries
        .map(
          (e) => {
            'recordedAt': e.recordedAt.toIso8601String(),
            'extractedColorHex': e.extractedColorHex,
            'memo': e.memo,
            'locationLat': e.locationLat,
            'locationLng': e.locationLng,
            'locationRecorded': e.locationRecorded,
            'themeName': e.dailyTheme.catalog.name,
            'themeDate': e.dailyTheme.date.toIso8601String(),
            'poeticPhrase': e.dailyTheme.poeticPhrase,
            'photoFileName': p.basename(e.photoPath),
          },
        )
        .toList();

    final archive = Archive();

    final jsonBytes = utf8.encode(
      const JsonEncoder.withIndent('  ').convert({
        'entries': entriesJson,
        'dailyThemes': dailyThemesJson,
      }),
    );
    archive.addFile(
      ArchiveFile('entries.json', jsonBytes.length, jsonBytes),
    );

    for (final entry in entries) {
      final photoFile = File(entry.photoPath);
      if (await photoFile.exists()) {
        final bytes = await photoFile.readAsBytes();
        archive.addFile(
          ArchiveFile(
            'photos/${p.basename(entry.photoPath)}',
            bytes.length,
            bytes,
          ),
        );
      }
    }

    final zipData = ZipEncoder().encode(archive);
    final zipFile = File(
      p.join(
        outputDir.path,
        'sozoroiro_export_${DateTime.now().millisecondsSinceEpoch}.zip',
      ),
    );
    await zipFile.writeAsBytes(zipData);
    return zipFile;
  }

  Future<List<DailyTheme>> _fetchAllDailyThemes() async {
    final result = <DailyTheme>[];
    var page = 0;
    while (true) {
      final themePage = await _themeRepository.fetchPastThemes(
        page: page,
        pageSize: 100,
      );
      result.addAll(themePage.items);
      if (!themePage.hasMore) break;
      page++;
    }
    return result;
  }
}
