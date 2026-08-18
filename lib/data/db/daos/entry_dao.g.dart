// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_dao.dart';

// ignore_for_file: type=lint
mixin _$EntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $ThemeCatalogTable get themeCatalog => attachedDatabase.themeCatalog;
  $DailyThemesTable get dailyThemes => attachedDatabase.dailyThemes;
  $EntriesTable get entries => attachedDatabase.entries;
  EntryDaoManager get managers => EntryDaoManager(this);
}

class EntryDaoManager {
  final _$EntryDaoMixin _db;
  EntryDaoManager(this._db);
  $$ThemeCatalogTableTableManager get themeCatalog =>
      $$ThemeCatalogTableTableManager(_db.attachedDatabase, _db.themeCatalog);
  $$DailyThemesTableTableManager get dailyThemes =>
      $$DailyThemesTableTableManager(_db.attachedDatabase, _db.dailyThemes);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db.attachedDatabase, _db.entries);
}
