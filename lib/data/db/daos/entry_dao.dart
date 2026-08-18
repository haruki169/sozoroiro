import 'package:drift/drift.dart';

import '../app_database.dart';

part 'entry_dao.g.dart';

class EntryWithTheme {
  EntryWithTheme({
    required this.entry,
    required this.dailyTheme,
    required this.catalog,
  });

  final EntryRow entry;
  final DailyThemeRow dailyTheme;
  final ThemeCatalogData catalog;
}

@DriftAccessor(tables: [Entries, DailyThemes, ThemeCatalog])
class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
  EntryDao(super.db);

  Future<int> insertEntry(EntriesCompanion entry) {
    return into(entries).insert(entry);
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinedQuery() {
    return select(entries).join([
      innerJoin(
        dailyThemes,
        dailyThemes.id.equalsExp(entries.dailyThemeId),
      ),
      innerJoin(
        themeCatalog,
        themeCatalog.id.equalsExp(dailyThemes.catalogId),
      ),
    ]);
  }

  List<EntryWithTheme> _mapRows(List<TypedResult> rows) {
    return rows
        .map(
          (row) => EntryWithTheme(
            entry: row.readTable(entries),
            dailyTheme: row.readTable(dailyThemes),
            catalog: row.readTable(themeCatalog),
          ),
        )
        .toList();
  }

  /// 色の日記画面用（日時降順、deletedAt IS NULL）。
  Stream<List<EntryWithTheme>> watchTimeline() {
    final query = _joinedQuery()
      ..where(entries.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(entries.recordedAt)]);
    return query.watch().map(_mapRows);
  }

  /// 色の地図画面用（locationRecorded=true かつ deletedAt IS NULL）。
  Future<List<EntryWithTheme>> fetchWithLocation() async {
    final query = _joinedQuery()
      ..where(
        entries.locationRecorded.equals(true) & entries.deletedAt.isNull(),
      );
    return _mapRows(await query.get());
  }

  /// グラデーションリボン用（指定範囲、deletedAt IS NULL）。
  Future<List<EntryWithTheme>> fetchForRibbon(DateTime from, DateTime to) async {
    final query = _joinedQuery()
      ..where(
        entries.recordedAt.isBetweenValues(from, to) &
            entries.deletedAt.isNull(),
      )
      ..orderBy([OrderingTerm.asc(entries.recordedAt)]);
    return _mapRows(await query.get());
  }

  Future<void> softDeleteEntry(int id) {
    return (update(entries)..where((t) => t.id.equals(id))).write(
      EntriesCompanion(deletedAt: Value(DateTime.now())),
    );
  }
}
