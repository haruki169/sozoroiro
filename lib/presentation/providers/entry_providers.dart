import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/entry_repository.dart';
import '../../data/services/export_service.dart';
import '../../domain/models/entry.dart';
import 'theme_providers.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return EntryRepository(ref.watch(appDatabaseProvider));
});

final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService(
    ref.watch(entryRepositoryProvider),
    ref.watch(themeRepositoryProvider),
  );
});

final timelineProvider = StreamProvider<List<Entry>>((ref) {
  return ref.watch(entryRepositoryProvider).watchTimeline();
});

/// 直近1週間分（グラデーションリボン用）。
final ribbonEntriesProvider = FutureProvider.autoDispose<List<Entry>>((
  ref,
) async {
  final now = DateTime.now();
  final from = now.subtract(const Duration(days: 7));
  return ref.watch(entryRepositoryProvider).fetchForRibbon(from, now);
});

/// 色の地図画面用。
final locatedEntriesProvider = FutureProvider.autoDispose<List<Entry>>((
  ref,
) async {
  return ref.watch(entryRepositoryProvider).fetchWithLocation();
});
