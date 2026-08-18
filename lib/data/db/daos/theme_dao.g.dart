// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_dao.dart';

// ignore_for_file: type=lint
mixin _$ThemeDaoMixin on DatabaseAccessor<AppDatabase> {
  $ThemeCatalogTable get themeCatalog => attachedDatabase.themeCatalog;
  $DailyThemesTable get dailyThemes => attachedDatabase.dailyThemes;
  ThemeDaoManager get managers => ThemeDaoManager(this);
}

class ThemeDaoManager {
  final _$ThemeDaoMixin _db;
  ThemeDaoManager(this._db);
  $$ThemeCatalogTableTableManager get themeCatalog =>
      $$ThemeCatalogTableTableManager(_db.attachedDatabase, _db.themeCatalog);
  $$DailyThemesTableTableManager get dailyThemes =>
      $$DailyThemesTableTableManager(_db.attachedDatabase, _db.dailyThemes);
}
