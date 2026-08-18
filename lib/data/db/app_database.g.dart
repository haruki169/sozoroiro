// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ThemeCatalogTable extends ThemeCatalog
    with TableInfo<$ThemeCatalogTable, ThemeCatalogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemeCatalogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _catalogKeyMeta =
      const VerificationMeta('catalogKey');
  @override
  late final GeneratedColumn<String> catalogKey = GeneratedColumn<String>(
      'catalog_key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _seasonTagsJsonMeta =
      const VerificationMeta('seasonTagsJson');
  @override
  late final GeneratedColumn<String> seasonTagsJson = GeneratedColumn<String>(
      'season_tags_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weatherTagsJsonMeta =
      const VerificationMeta('weatherTagsJson');
  @override
  late final GeneratedColumn<String> weatherTagsJson = GeneratedColumn<String>(
      'weather_tags_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _poeticPhrasesJsonMeta =
      const VerificationMeta('poeticPhrasesJson');
  @override
  late final GeneratedColumn<String> poeticPhrasesJson =
      GeneratedColumn<String>('poetic_phrases_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        catalogKey,
        name,
        colorHex,
        seasonTagsJson,
        weatherTagsJson,
        poeticPhrasesJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theme_catalog';
  @override
  VerificationContext validateIntegrity(Insertable<ThemeCatalogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('catalog_key')) {
      context.handle(
          _catalogKeyMeta,
          catalogKey.isAcceptableOrUnknown(
              data['catalog_key']!, _catalogKeyMeta));
    } else if (isInserting) {
      context.missing(_catalogKeyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('season_tags_json')) {
      context.handle(
          _seasonTagsJsonMeta,
          seasonTagsJson.isAcceptableOrUnknown(
              data['season_tags_json']!, _seasonTagsJsonMeta));
    } else if (isInserting) {
      context.missing(_seasonTagsJsonMeta);
    }
    if (data.containsKey('weather_tags_json')) {
      context.handle(
          _weatherTagsJsonMeta,
          weatherTagsJson.isAcceptableOrUnknown(
              data['weather_tags_json']!, _weatherTagsJsonMeta));
    } else if (isInserting) {
      context.missing(_weatherTagsJsonMeta);
    }
    if (data.containsKey('poetic_phrases_json')) {
      context.handle(
          _poeticPhrasesJsonMeta,
          poeticPhrasesJson.isAcceptableOrUnknown(
              data['poetic_phrases_json']!, _poeticPhrasesJsonMeta));
    } else if (isInserting) {
      context.missing(_poeticPhrasesJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThemeCatalogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemeCatalogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      catalogKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}catalog_key'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      seasonTagsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}season_tags_json'])!,
      weatherTagsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}weather_tags_json'])!,
      poeticPhrasesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}poetic_phrases_json'])!,
    );
  }

  @override
  $ThemeCatalogTable createAlias(String alias) {
    return $ThemeCatalogTable(attachedDatabase, alias);
  }
}

class ThemeCatalogData extends DataClass
    implements Insertable<ThemeCatalogData> {
  final int id;
  final String catalogKey;
  final String name;
  final String colorHex;
  final String seasonTagsJson;
  final String weatherTagsJson;
  final String poeticPhrasesJson;
  const ThemeCatalogData(
      {required this.id,
      required this.catalogKey,
      required this.name,
      required this.colorHex,
      required this.seasonTagsJson,
      required this.weatherTagsJson,
      required this.poeticPhrasesJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['catalog_key'] = Variable<String>(catalogKey);
    map['name'] = Variable<String>(name);
    map['color_hex'] = Variable<String>(colorHex);
    map['season_tags_json'] = Variable<String>(seasonTagsJson);
    map['weather_tags_json'] = Variable<String>(weatherTagsJson);
    map['poetic_phrases_json'] = Variable<String>(poeticPhrasesJson);
    return map;
  }

  ThemeCatalogCompanion toCompanion(bool nullToAbsent) {
    return ThemeCatalogCompanion(
      id: Value(id),
      catalogKey: Value(catalogKey),
      name: Value(name),
      colorHex: Value(colorHex),
      seasonTagsJson: Value(seasonTagsJson),
      weatherTagsJson: Value(weatherTagsJson),
      poeticPhrasesJson: Value(poeticPhrasesJson),
    );
  }

  factory ThemeCatalogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemeCatalogData(
      id: serializer.fromJson<int>(json['id']),
      catalogKey: serializer.fromJson<String>(json['catalogKey']),
      name: serializer.fromJson<String>(json['name']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      seasonTagsJson: serializer.fromJson<String>(json['seasonTagsJson']),
      weatherTagsJson: serializer.fromJson<String>(json['weatherTagsJson']),
      poeticPhrasesJson: serializer.fromJson<String>(json['poeticPhrasesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'catalogKey': serializer.toJson<String>(catalogKey),
      'name': serializer.toJson<String>(name),
      'colorHex': serializer.toJson<String>(colorHex),
      'seasonTagsJson': serializer.toJson<String>(seasonTagsJson),
      'weatherTagsJson': serializer.toJson<String>(weatherTagsJson),
      'poeticPhrasesJson': serializer.toJson<String>(poeticPhrasesJson),
    };
  }

  ThemeCatalogData copyWith(
          {int? id,
          String? catalogKey,
          String? name,
          String? colorHex,
          String? seasonTagsJson,
          String? weatherTagsJson,
          String? poeticPhrasesJson}) =>
      ThemeCatalogData(
        id: id ?? this.id,
        catalogKey: catalogKey ?? this.catalogKey,
        name: name ?? this.name,
        colorHex: colorHex ?? this.colorHex,
        seasonTagsJson: seasonTagsJson ?? this.seasonTagsJson,
        weatherTagsJson: weatherTagsJson ?? this.weatherTagsJson,
        poeticPhrasesJson: poeticPhrasesJson ?? this.poeticPhrasesJson,
      );
  ThemeCatalogData copyWithCompanion(ThemeCatalogCompanion data) {
    return ThemeCatalogData(
      id: data.id.present ? data.id.value : this.id,
      catalogKey:
          data.catalogKey.present ? data.catalogKey.value : this.catalogKey,
      name: data.name.present ? data.name.value : this.name,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      seasonTagsJson: data.seasonTagsJson.present
          ? data.seasonTagsJson.value
          : this.seasonTagsJson,
      weatherTagsJson: data.weatherTagsJson.present
          ? data.weatherTagsJson.value
          : this.weatherTagsJson,
      poeticPhrasesJson: data.poeticPhrasesJson.present
          ? data.poeticPhrasesJson.value
          : this.poeticPhrasesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemeCatalogData(')
          ..write('id: $id, ')
          ..write('catalogKey: $catalogKey, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('seasonTagsJson: $seasonTagsJson, ')
          ..write('weatherTagsJson: $weatherTagsJson, ')
          ..write('poeticPhrasesJson: $poeticPhrasesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, catalogKey, name, colorHex,
      seasonTagsJson, weatherTagsJson, poeticPhrasesJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemeCatalogData &&
          other.id == this.id &&
          other.catalogKey == this.catalogKey &&
          other.name == this.name &&
          other.colorHex == this.colorHex &&
          other.seasonTagsJson == this.seasonTagsJson &&
          other.weatherTagsJson == this.weatherTagsJson &&
          other.poeticPhrasesJson == this.poeticPhrasesJson);
}

class ThemeCatalogCompanion extends UpdateCompanion<ThemeCatalogData> {
  final Value<int> id;
  final Value<String> catalogKey;
  final Value<String> name;
  final Value<String> colorHex;
  final Value<String> seasonTagsJson;
  final Value<String> weatherTagsJson;
  final Value<String> poeticPhrasesJson;
  const ThemeCatalogCompanion({
    this.id = const Value.absent(),
    this.catalogKey = const Value.absent(),
    this.name = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.seasonTagsJson = const Value.absent(),
    this.weatherTagsJson = const Value.absent(),
    this.poeticPhrasesJson = const Value.absent(),
  });
  ThemeCatalogCompanion.insert({
    this.id = const Value.absent(),
    required String catalogKey,
    required String name,
    required String colorHex,
    required String seasonTagsJson,
    required String weatherTagsJson,
    required String poeticPhrasesJson,
  })  : catalogKey = Value(catalogKey),
        name = Value(name),
        colorHex = Value(colorHex),
        seasonTagsJson = Value(seasonTagsJson),
        weatherTagsJson = Value(weatherTagsJson),
        poeticPhrasesJson = Value(poeticPhrasesJson);
  static Insertable<ThemeCatalogData> custom({
    Expression<int>? id,
    Expression<String>? catalogKey,
    Expression<String>? name,
    Expression<String>? colorHex,
    Expression<String>? seasonTagsJson,
    Expression<String>? weatherTagsJson,
    Expression<String>? poeticPhrasesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (catalogKey != null) 'catalog_key': catalogKey,
      if (name != null) 'name': name,
      if (colorHex != null) 'color_hex': colorHex,
      if (seasonTagsJson != null) 'season_tags_json': seasonTagsJson,
      if (weatherTagsJson != null) 'weather_tags_json': weatherTagsJson,
      if (poeticPhrasesJson != null) 'poetic_phrases_json': poeticPhrasesJson,
    });
  }

  ThemeCatalogCompanion copyWith(
      {Value<int>? id,
      Value<String>? catalogKey,
      Value<String>? name,
      Value<String>? colorHex,
      Value<String>? seasonTagsJson,
      Value<String>? weatherTagsJson,
      Value<String>? poeticPhrasesJson}) {
    return ThemeCatalogCompanion(
      id: id ?? this.id,
      catalogKey: catalogKey ?? this.catalogKey,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      seasonTagsJson: seasonTagsJson ?? this.seasonTagsJson,
      weatherTagsJson: weatherTagsJson ?? this.weatherTagsJson,
      poeticPhrasesJson: poeticPhrasesJson ?? this.poeticPhrasesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (catalogKey.present) {
      map['catalog_key'] = Variable<String>(catalogKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (seasonTagsJson.present) {
      map['season_tags_json'] = Variable<String>(seasonTagsJson.value);
    }
    if (weatherTagsJson.present) {
      map['weather_tags_json'] = Variable<String>(weatherTagsJson.value);
    }
    if (poeticPhrasesJson.present) {
      map['poetic_phrases_json'] = Variable<String>(poeticPhrasesJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemeCatalogCompanion(')
          ..write('id: $id, ')
          ..write('catalogKey: $catalogKey, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('seasonTagsJson: $seasonTagsJson, ')
          ..write('weatherTagsJson: $weatherTagsJson, ')
          ..write('poeticPhrasesJson: $poeticPhrasesJson')
          ..write(')'))
        .toString();
  }
}

class $DailyThemesTable extends DailyThemes
    with TableInfo<$DailyThemesTable, DailyThemeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyThemesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _catalogIdMeta =
      const VerificationMeta('catalogId');
  @override
  late final GeneratedColumn<int> catalogId = GeneratedColumn<int>(
      'catalog_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES theme_catalog (id)'));
  static const VerificationMeta _poeticPhraseMeta =
      const VerificationMeta('poeticPhrase');
  @override
  late final GeneratedColumn<String> poeticPhrase = GeneratedColumn<String>(
      'poetic_phrase', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, catalogId, poeticPhrase, createdAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_themes';
  @override
  VerificationContext validateIntegrity(Insertable<DailyThemeRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('catalog_id')) {
      context.handle(_catalogIdMeta,
          catalogId.isAcceptableOrUnknown(data['catalog_id']!, _catalogIdMeta));
    } else if (isInserting) {
      context.missing(_catalogIdMeta);
    }
    if (data.containsKey('poetic_phrase')) {
      context.handle(
          _poeticPhraseMeta,
          poeticPhrase.isAcceptableOrUnknown(
              data['poetic_phrase']!, _poeticPhraseMeta));
    } else if (isInserting) {
      context.missing(_poeticPhraseMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyThemeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyThemeRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      catalogId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}catalog_id'])!,
      poeticPhrase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poetic_phrase'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $DailyThemesTable createAlias(String alias) {
    return $DailyThemesTable(attachedDatabase, alias);
  }
}

class DailyThemeRow extends DataClass implements Insertable<DailyThemeRow> {
  final int id;
  final DateTime date;
  final int catalogId;
  final String poeticPhrase;
  final DateTime createdAt;
  final DateTime? deletedAt;
  const DailyThemeRow(
      {required this.id,
      required this.date,
      required this.catalogId,
      required this.poeticPhrase,
      required this.createdAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['catalog_id'] = Variable<int>(catalogId);
    map['poetic_phrase'] = Variable<String>(poeticPhrase);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  DailyThemesCompanion toCompanion(bool nullToAbsent) {
    return DailyThemesCompanion(
      id: Value(id),
      date: Value(date),
      catalogId: Value(catalogId),
      poeticPhrase: Value(poeticPhrase),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory DailyThemeRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyThemeRow(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      catalogId: serializer.fromJson<int>(json['catalogId']),
      poeticPhrase: serializer.fromJson<String>(json['poeticPhrase']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'catalogId': serializer.toJson<int>(catalogId),
      'poeticPhrase': serializer.toJson<String>(poeticPhrase),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  DailyThemeRow copyWith(
          {int? id,
          DateTime? date,
          int? catalogId,
          String? poeticPhrase,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      DailyThemeRow(
        id: id ?? this.id,
        date: date ?? this.date,
        catalogId: catalogId ?? this.catalogId,
        poeticPhrase: poeticPhrase ?? this.poeticPhrase,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  DailyThemeRow copyWithCompanion(DailyThemesCompanion data) {
    return DailyThemeRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      catalogId: data.catalogId.present ? data.catalogId.value : this.catalogId,
      poeticPhrase: data.poeticPhrase.present
          ? data.poeticPhrase.value
          : this.poeticPhrase,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyThemeRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('catalogId: $catalogId, ')
          ..write('poeticPhrase: $poeticPhrase, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, catalogId, poeticPhrase, createdAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyThemeRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.catalogId == this.catalogId &&
          other.poeticPhrase == this.poeticPhrase &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class DailyThemesCompanion extends UpdateCompanion<DailyThemeRow> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> catalogId;
  final Value<String> poeticPhrase;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  const DailyThemesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.catalogId = const Value.absent(),
    this.poeticPhrase = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  DailyThemesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int catalogId,
    required String poeticPhrase,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : date = Value(date),
        catalogId = Value(catalogId),
        poeticPhrase = Value(poeticPhrase);
  static Insertable<DailyThemeRow> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? catalogId,
    Expression<String>? poeticPhrase,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (catalogId != null) 'catalog_id': catalogId,
      if (poeticPhrase != null) 'poetic_phrase': poeticPhrase,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  DailyThemesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? catalogId,
      Value<String>? poeticPhrase,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt}) {
    return DailyThemesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      catalogId: catalogId ?? this.catalogId,
      poeticPhrase: poeticPhrase ?? this.poeticPhrase,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (catalogId.present) {
      map['catalog_id'] = Variable<int>(catalogId.value);
    }
    if (poeticPhrase.present) {
      map['poetic_phrase'] = Variable<String>(poeticPhrase.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyThemesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('catalogId: $catalogId, ')
          ..write('poeticPhrase: $poeticPhrase, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $EntriesTable extends Entries with TableInfo<$EntriesTable, EntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _extractedColorHexMeta =
      const VerificationMeta('extractedColorHex');
  @override
  late final GeneratedColumn<String> extractedColorHex =
      GeneratedColumn<String>('extracted_color_hex', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dailyThemeIdMeta =
      const VerificationMeta('dailyThemeId');
  @override
  late final GeneratedColumn<int> dailyThemeId = GeneratedColumn<int>(
      'daily_theme_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES daily_themes (id)'));
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationLatMeta =
      const VerificationMeta('locationLat');
  @override
  late final GeneratedColumn<double> locationLat = GeneratedColumn<double>(
      'location_lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationLngMeta =
      const VerificationMeta('locationLng');
  @override
  late final GeneratedColumn<double> locationLng = GeneratedColumn<double>(
      'location_lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationRecordedMeta =
      const VerificationMeta('locationRecorded');
  @override
  late final GeneratedColumn<bool> locationRecorded = GeneratedColumn<bool>(
      'location_recorded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("location_recorded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        recordedAt,
        photoPath,
        extractedColorHex,
        dailyThemeId,
        memo,
        locationLat,
        locationLng,
        locationRecorded,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(Insertable<EntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    } else if (isInserting) {
      context.missing(_photoPathMeta);
    }
    if (data.containsKey('extracted_color_hex')) {
      context.handle(
          _extractedColorHexMeta,
          extractedColorHex.isAcceptableOrUnknown(
              data['extracted_color_hex']!, _extractedColorHexMeta));
    } else if (isInserting) {
      context.missing(_extractedColorHexMeta);
    }
    if (data.containsKey('daily_theme_id')) {
      context.handle(
          _dailyThemeIdMeta,
          dailyThemeId.isAcceptableOrUnknown(
              data['daily_theme_id']!, _dailyThemeIdMeta));
    } else if (isInserting) {
      context.missing(_dailyThemeIdMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('location_lat')) {
      context.handle(
          _locationLatMeta,
          locationLat.isAcceptableOrUnknown(
              data['location_lat']!, _locationLatMeta));
    }
    if (data.containsKey('location_lng')) {
      context.handle(
          _locationLngMeta,
          locationLng.isAcceptableOrUnknown(
              data['location_lng']!, _locationLngMeta));
    }
    if (data.containsKey('location_recorded')) {
      context.handle(
          _locationRecordedMeta,
          locationRecorded.isAcceptableOrUnknown(
              data['location_recorded']!, _locationRecordedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path'])!,
      extractedColorHex: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}extracted_color_hex'])!,
      dailyThemeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_theme_id'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      locationLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_lat']),
      locationLng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_lng']),
      locationRecorded: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}location_recorded'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(attachedDatabase, alias);
  }
}

class EntryRow extends DataClass implements Insertable<EntryRow> {
  final int id;
  final DateTime recordedAt;
  final String photoPath;
  final String extractedColorHex;
  final int dailyThemeId;
  final String? memo;
  final double? locationLat;
  final double? locationLng;
  final bool locationRecorded;
  final DateTime? deletedAt;
  const EntryRow(
      {required this.id,
      required this.recordedAt,
      required this.photoPath,
      required this.extractedColorHex,
      required this.dailyThemeId,
      this.memo,
      this.locationLat,
      this.locationLng,
      required this.locationRecorded,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['photo_path'] = Variable<String>(photoPath);
    map['extracted_color_hex'] = Variable<String>(extractedColorHex);
    map['daily_theme_id'] = Variable<int>(dailyThemeId);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    if (!nullToAbsent || locationLat != null) {
      map['location_lat'] = Variable<double>(locationLat);
    }
    if (!nullToAbsent || locationLng != null) {
      map['location_lng'] = Variable<double>(locationLng);
    }
    map['location_recorded'] = Variable<bool>(locationRecorded);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: Value(id),
      recordedAt: Value(recordedAt),
      photoPath: Value(photoPath),
      extractedColorHex: Value(extractedColorHex),
      dailyThemeId: Value(dailyThemeId),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      locationLat: locationLat == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLat),
      locationLng: locationLng == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLng),
      locationRecorded: Value(locationRecorded),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory EntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryRow(
      id: serializer.fromJson<int>(json['id']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
      extractedColorHex: serializer.fromJson<String>(json['extractedColorHex']),
      dailyThemeId: serializer.fromJson<int>(json['dailyThemeId']),
      memo: serializer.fromJson<String?>(json['memo']),
      locationLat: serializer.fromJson<double?>(json['locationLat']),
      locationLng: serializer.fromJson<double?>(json['locationLng']),
      locationRecorded: serializer.fromJson<bool>(json['locationRecorded']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'photoPath': serializer.toJson<String>(photoPath),
      'extractedColorHex': serializer.toJson<String>(extractedColorHex),
      'dailyThemeId': serializer.toJson<int>(dailyThemeId),
      'memo': serializer.toJson<String?>(memo),
      'locationLat': serializer.toJson<double?>(locationLat),
      'locationLng': serializer.toJson<double?>(locationLng),
      'locationRecorded': serializer.toJson<bool>(locationRecorded),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  EntryRow copyWith(
          {int? id,
          DateTime? recordedAt,
          String? photoPath,
          String? extractedColorHex,
          int? dailyThemeId,
          Value<String?> memo = const Value.absent(),
          Value<double?> locationLat = const Value.absent(),
          Value<double?> locationLng = const Value.absent(),
          bool? locationRecorded,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      EntryRow(
        id: id ?? this.id,
        recordedAt: recordedAt ?? this.recordedAt,
        photoPath: photoPath ?? this.photoPath,
        extractedColorHex: extractedColorHex ?? this.extractedColorHex,
        dailyThemeId: dailyThemeId ?? this.dailyThemeId,
        memo: memo.present ? memo.value : this.memo,
        locationLat: locationLat.present ? locationLat.value : this.locationLat,
        locationLng: locationLng.present ? locationLng.value : this.locationLng,
        locationRecorded: locationRecorded ?? this.locationRecorded,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  EntryRow copyWithCompanion(EntriesCompanion data) {
    return EntryRow(
      id: data.id.present ? data.id.value : this.id,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      extractedColorHex: data.extractedColorHex.present
          ? data.extractedColorHex.value
          : this.extractedColorHex,
      dailyThemeId: data.dailyThemeId.present
          ? data.dailyThemeId.value
          : this.dailyThemeId,
      memo: data.memo.present ? data.memo.value : this.memo,
      locationLat:
          data.locationLat.present ? data.locationLat.value : this.locationLat,
      locationLng:
          data.locationLng.present ? data.locationLng.value : this.locationLng,
      locationRecorded: data.locationRecorded.present
          ? data.locationRecorded.value
          : this.locationRecorded,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryRow(')
          ..write('id: $id, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('photoPath: $photoPath, ')
          ..write('extractedColorHex: $extractedColorHex, ')
          ..write('dailyThemeId: $dailyThemeId, ')
          ..write('memo: $memo, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('locationRecorded: $locationRecorded, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      recordedAt,
      photoPath,
      extractedColorHex,
      dailyThemeId,
      memo,
      locationLat,
      locationLng,
      locationRecorded,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryRow &&
          other.id == this.id &&
          other.recordedAt == this.recordedAt &&
          other.photoPath == this.photoPath &&
          other.extractedColorHex == this.extractedColorHex &&
          other.dailyThemeId == this.dailyThemeId &&
          other.memo == this.memo &&
          other.locationLat == this.locationLat &&
          other.locationLng == this.locationLng &&
          other.locationRecorded == this.locationRecorded &&
          other.deletedAt == this.deletedAt);
}

class EntriesCompanion extends UpdateCompanion<EntryRow> {
  final Value<int> id;
  final Value<DateTime> recordedAt;
  final Value<String> photoPath;
  final Value<String> extractedColorHex;
  final Value<int> dailyThemeId;
  final Value<String?> memo;
  final Value<double?> locationLat;
  final Value<double?> locationLng;
  final Value<bool> locationRecorded;
  final Value<DateTime?> deletedAt;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.extractedColorHex = const Value.absent(),
    this.dailyThemeId = const Value.absent(),
    this.memo = const Value.absent(),
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.locationRecorded = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  EntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime recordedAt,
    required String photoPath,
    required String extractedColorHex,
    required int dailyThemeId,
    this.memo = const Value.absent(),
    this.locationLat = const Value.absent(),
    this.locationLng = const Value.absent(),
    this.locationRecorded = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : recordedAt = Value(recordedAt),
        photoPath = Value(photoPath),
        extractedColorHex = Value(extractedColorHex),
        dailyThemeId = Value(dailyThemeId);
  static Insertable<EntryRow> custom({
    Expression<int>? id,
    Expression<DateTime>? recordedAt,
    Expression<String>? photoPath,
    Expression<String>? extractedColorHex,
    Expression<int>? dailyThemeId,
    Expression<String>? memo,
    Expression<double>? locationLat,
    Expression<double>? locationLng,
    Expression<bool>? locationRecorded,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (photoPath != null) 'photo_path': photoPath,
      if (extractedColorHex != null) 'extracted_color_hex': extractedColorHex,
      if (dailyThemeId != null) 'daily_theme_id': dailyThemeId,
      if (memo != null) 'memo': memo,
      if (locationLat != null) 'location_lat': locationLat,
      if (locationLng != null) 'location_lng': locationLng,
      if (locationRecorded != null) 'location_recorded': locationRecorded,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  EntriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? recordedAt,
      Value<String>? photoPath,
      Value<String>? extractedColorHex,
      Value<int>? dailyThemeId,
      Value<String?>? memo,
      Value<double?>? locationLat,
      Value<double?>? locationLng,
      Value<bool>? locationRecorded,
      Value<DateTime?>? deletedAt}) {
    return EntriesCompanion(
      id: id ?? this.id,
      recordedAt: recordedAt ?? this.recordedAt,
      photoPath: photoPath ?? this.photoPath,
      extractedColorHex: extractedColorHex ?? this.extractedColorHex,
      dailyThemeId: dailyThemeId ?? this.dailyThemeId,
      memo: memo ?? this.memo,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      locationRecorded: locationRecorded ?? this.locationRecorded,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (extractedColorHex.present) {
      map['extracted_color_hex'] = Variable<String>(extractedColorHex.value);
    }
    if (dailyThemeId.present) {
      map['daily_theme_id'] = Variable<int>(dailyThemeId.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (locationLat.present) {
      map['location_lat'] = Variable<double>(locationLat.value);
    }
    if (locationLng.present) {
      map['location_lng'] = Variable<double>(locationLng.value);
    }
    if (locationRecorded.present) {
      map['location_recorded'] = Variable<bool>(locationRecorded.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('photoPath: $photoPath, ')
          ..write('extractedColorHex: $extractedColorHex, ')
          ..write('dailyThemeId: $dailyThemeId, ')
          ..write('memo: $memo, ')
          ..write('locationLat: $locationLat, ')
          ..write('locationLng: $locationLng, ')
          ..write('locationRecorded: $locationRecorded, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _notificationEnabledMeta =
      const VerificationMeta('notificationEnabled');
  @override
  late final GeneratedColumn<bool> notificationEnabled = GeneratedColumn<bool>(
      'notification_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _notificationFrequencyMeta =
      const VerificationMeta('notificationFrequency');
  @override
  late final GeneratedColumn<String> notificationFrequency =
      GeneratedColumn<String>('notification_frequency', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('occasionally'));
  static const VerificationMeta _locationFeatureEnabledMeta =
      const VerificationMeta('locationFeatureEnabled');
  @override
  late final GeneratedColumn<bool> locationFeatureEnabled =
      GeneratedColumn<bool>('location_feature_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("location_feature_enabled" IN (0, 1))'),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, notificationEnabled, notificationFrequency, locationFeatureEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notification_enabled')) {
      context.handle(
          _notificationEnabledMeta,
          notificationEnabled.isAcceptableOrUnknown(
              data['notification_enabled']!, _notificationEnabledMeta));
    }
    if (data.containsKey('notification_frequency')) {
      context.handle(
          _notificationFrequencyMeta,
          notificationFrequency.isAcceptableOrUnknown(
              data['notification_frequency']!, _notificationFrequencyMeta));
    }
    if (data.containsKey('location_feature_enabled')) {
      context.handle(
          _locationFeatureEnabledMeta,
          locationFeatureEnabled.isAcceptableOrUnknown(
              data['location_feature_enabled']!, _locationFeatureEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notificationEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notification_enabled'])!,
      notificationFrequency: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}notification_frequency'])!,
      locationFeatureEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}location_feature_enabled'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final bool notificationEnabled;
  final String notificationFrequency;
  final bool locationFeatureEnabled;
  const SettingsRow(
      {required this.id,
      required this.notificationEnabled,
      required this.notificationFrequency,
      required this.locationFeatureEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notification_enabled'] = Variable<bool>(notificationEnabled);
    map['notification_frequency'] = Variable<String>(notificationFrequency);
    map['location_feature_enabled'] = Variable<bool>(locationFeatureEnabled);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      notificationEnabled: Value(notificationEnabled),
      notificationFrequency: Value(notificationFrequency),
      locationFeatureEnabled: Value(locationFeatureEnabled),
    );
  }

  factory SettingsRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      notificationEnabled:
          serializer.fromJson<bool>(json['notificationEnabled']),
      notificationFrequency:
          serializer.fromJson<String>(json['notificationFrequency']),
      locationFeatureEnabled:
          serializer.fromJson<bool>(json['locationFeatureEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationEnabled': serializer.toJson<bool>(notificationEnabled),
      'notificationFrequency': serializer.toJson<String>(notificationFrequency),
      'locationFeatureEnabled': serializer.toJson<bool>(locationFeatureEnabled),
    };
  }

  SettingsRow copyWith(
          {int? id,
          bool? notificationEnabled,
          String? notificationFrequency,
          bool? locationFeatureEnabled}) =>
      SettingsRow(
        id: id ?? this.id,
        notificationEnabled: notificationEnabled ?? this.notificationEnabled,
        notificationFrequency:
            notificationFrequency ?? this.notificationFrequency,
        locationFeatureEnabled:
            locationFeatureEnabled ?? this.locationFeatureEnabled,
      );
  SettingsRow copyWithCompanion(SettingsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      notificationEnabled: data.notificationEnabled.present
          ? data.notificationEnabled.value
          : this.notificationEnabled,
      notificationFrequency: data.notificationFrequency.present
          ? data.notificationFrequency.value
          : this.notificationFrequency,
      locationFeatureEnabled: data.locationFeatureEnabled.present
          ? data.locationFeatureEnabled.value
          : this.locationFeatureEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('notificationFrequency: $notificationFrequency, ')
          ..write('locationFeatureEnabled: $locationFeatureEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, notificationEnabled, notificationFrequency, locationFeatureEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.notificationEnabled == this.notificationEnabled &&
          other.notificationFrequency == this.notificationFrequency &&
          other.locationFeatureEnabled == this.locationFeatureEnabled);
}

class SettingsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<bool> notificationEnabled;
  final Value<String> notificationFrequency;
  final Value<bool> locationFeatureEnabled;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.notificationFrequency = const Value.absent(),
    this.locationFeatureEnabled = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.notificationFrequency = const Value.absent(),
    this.locationFeatureEnabled = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<bool>? notificationEnabled,
    Expression<String>? notificationFrequency,
    Expression<bool>? locationFeatureEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationEnabled != null)
        'notification_enabled': notificationEnabled,
      if (notificationFrequency != null)
        'notification_frequency': notificationFrequency,
      if (locationFeatureEnabled != null)
        'location_feature_enabled': locationFeatureEnabled,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? notificationEnabled,
      Value<String>? notificationFrequency,
      Value<bool>? locationFeatureEnabled}) {
    return SettingsCompanion(
      id: id ?? this.id,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      notificationFrequency:
          notificationFrequency ?? this.notificationFrequency,
      locationFeatureEnabled:
          locationFeatureEnabled ?? this.locationFeatureEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notificationEnabled.present) {
      map['notification_enabled'] = Variable<bool>(notificationEnabled.value);
    }
    if (notificationFrequency.present) {
      map['notification_frequency'] =
          Variable<String>(notificationFrequency.value);
    }
    if (locationFeatureEnabled.present) {
      map['location_feature_enabled'] =
          Variable<bool>(locationFeatureEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('notificationFrequency: $notificationFrequency, ')
          ..write('locationFeatureEnabled: $locationFeatureEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ThemeCatalogTable themeCatalog = $ThemeCatalogTable(this);
  late final $DailyThemesTable dailyThemes = $DailyThemesTable(this);
  late final $EntriesTable entries = $EntriesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final ThemeDao themeDao = ThemeDao(this as AppDatabase);
  late final EntryDao entryDao = EntryDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [themeCatalog, dailyThemes, entries, settings];
}

typedef $$ThemeCatalogTableCreateCompanionBuilder = ThemeCatalogCompanion
    Function({
  Value<int> id,
  required String catalogKey,
  required String name,
  required String colorHex,
  required String seasonTagsJson,
  required String weatherTagsJson,
  required String poeticPhrasesJson,
});
typedef $$ThemeCatalogTableUpdateCompanionBuilder = ThemeCatalogCompanion
    Function({
  Value<int> id,
  Value<String> catalogKey,
  Value<String> name,
  Value<String> colorHex,
  Value<String> seasonTagsJson,
  Value<String> weatherTagsJson,
  Value<String> poeticPhrasesJson,
});

final class $$ThemeCatalogTableReferences extends BaseReferences<_$AppDatabase,
    $ThemeCatalogTable, ThemeCatalogData> {
  $$ThemeCatalogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DailyThemesTable, List<DailyThemeRow>>
      _dailyThemesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dailyThemes,
              aliasName: 'theme_catalog__id__daily_themes__catalog_id');

  $$DailyThemesTableProcessedTableManager get dailyThemesRefs {
    final manager = $$DailyThemesTableTableManager($_db, $_db.dailyThemes)
        .filter((f) => f.catalogId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyThemesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ThemeCatalogTableFilterComposer
    extends Composer<_$AppDatabase, $ThemeCatalogTable> {
  $$ThemeCatalogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get catalogKey => $composableBuilder(
      column: $table.catalogKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get seasonTagsJson => $composableBuilder(
      column: $table.seasonTagsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weatherTagsJson => $composableBuilder(
      column: $table.weatherTagsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get poeticPhrasesJson => $composableBuilder(
      column: $table.poeticPhrasesJson,
      builder: (column) => ColumnFilters(column));

  Expression<bool> dailyThemesRefs(
      Expression<bool> Function($$DailyThemesTableFilterComposer f) f) {
    final $$DailyThemesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyThemes,
        getReferencedColumn: (t) => t.catalogId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyThemesTableFilterComposer(
              $db: $db,
              $table: $db.dailyThemes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ThemeCatalogTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemeCatalogTable> {
  $$ThemeCatalogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get catalogKey => $composableBuilder(
      column: $table.catalogKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get seasonTagsJson => $composableBuilder(
      column: $table.seasonTagsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weatherTagsJson => $composableBuilder(
      column: $table.weatherTagsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get poeticPhrasesJson => $composableBuilder(
      column: $table.poeticPhrasesJson,
      builder: (column) => ColumnOrderings(column));
}

class $$ThemeCatalogTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemeCatalogTable> {
  $$ThemeCatalogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get catalogKey => $composableBuilder(
      column: $table.catalogKey, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<String> get seasonTagsJson => $composableBuilder(
      column: $table.seasonTagsJson, builder: (column) => column);

  GeneratedColumn<String> get weatherTagsJson => $composableBuilder(
      column: $table.weatherTagsJson, builder: (column) => column);

  GeneratedColumn<String> get poeticPhrasesJson => $composableBuilder(
      column: $table.poeticPhrasesJson, builder: (column) => column);

  Expression<T> dailyThemesRefs<T extends Object>(
      Expression<T> Function($$DailyThemesTableAnnotationComposer a) f) {
    final $$DailyThemesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyThemes,
        getReferencedColumn: (t) => t.catalogId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyThemesTableAnnotationComposer(
              $db: $db,
              $table: $db.dailyThemes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ThemeCatalogTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ThemeCatalogTable,
    ThemeCatalogData,
    $$ThemeCatalogTableFilterComposer,
    $$ThemeCatalogTableOrderingComposer,
    $$ThemeCatalogTableAnnotationComposer,
    $$ThemeCatalogTableCreateCompanionBuilder,
    $$ThemeCatalogTableUpdateCompanionBuilder,
    (ThemeCatalogData, $$ThemeCatalogTableReferences),
    ThemeCatalogData,
    PrefetchHooks Function({bool dailyThemesRefs})> {
  $$ThemeCatalogTableTableManager(_$AppDatabase db, $ThemeCatalogTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemeCatalogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemeCatalogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemeCatalogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> catalogKey = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<String> seasonTagsJson = const Value.absent(),
            Value<String> weatherTagsJson = const Value.absent(),
            Value<String> poeticPhrasesJson = const Value.absent(),
          }) =>
              ThemeCatalogCompanion(
            id: id,
            catalogKey: catalogKey,
            name: name,
            colorHex: colorHex,
            seasonTagsJson: seasonTagsJson,
            weatherTagsJson: weatherTagsJson,
            poeticPhrasesJson: poeticPhrasesJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String catalogKey,
            required String name,
            required String colorHex,
            required String seasonTagsJson,
            required String weatherTagsJson,
            required String poeticPhrasesJson,
          }) =>
              ThemeCatalogCompanion.insert(
            id: id,
            catalogKey: catalogKey,
            name: name,
            colorHex: colorHex,
            seasonTagsJson: seasonTagsJson,
            weatherTagsJson: weatherTagsJson,
            poeticPhrasesJson: poeticPhrasesJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ThemeCatalogTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dailyThemesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dailyThemesRefs) db.dailyThemes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dailyThemesRefs)
                    await $_getPrefetchedData<ThemeCatalogData,
                            $ThemeCatalogTable, DailyThemeRow>(
                        currentTable: table,
                        referencedTable: $$ThemeCatalogTableReferences
                            ._dailyThemesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ThemeCatalogTableReferences(db, table, p0)
                                .dailyThemesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.catalogId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ThemeCatalogTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ThemeCatalogTable,
    ThemeCatalogData,
    $$ThemeCatalogTableFilterComposer,
    $$ThemeCatalogTableOrderingComposer,
    $$ThemeCatalogTableAnnotationComposer,
    $$ThemeCatalogTableCreateCompanionBuilder,
    $$ThemeCatalogTableUpdateCompanionBuilder,
    (ThemeCatalogData, $$ThemeCatalogTableReferences),
    ThemeCatalogData,
    PrefetchHooks Function({bool dailyThemesRefs})>;
typedef $$DailyThemesTableCreateCompanionBuilder = DailyThemesCompanion
    Function({
  Value<int> id,
  required DateTime date,
  required int catalogId,
  required String poeticPhrase,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
});
typedef $$DailyThemesTableUpdateCompanionBuilder = DailyThemesCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> catalogId,
  Value<String> poeticPhrase,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
});

final class $$DailyThemesTableReferences
    extends BaseReferences<_$AppDatabase, $DailyThemesTable, DailyThemeRow> {
  $$DailyThemesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ThemeCatalogTable _catalogIdTable(_$AppDatabase db) => db.themeCatalog
      .createAlias('daily_themes__catalog_id__theme_catalog__id');

  $$ThemeCatalogTableProcessedTableManager get catalogId {
    final $_column = $_itemColumn<int>('catalog_id')!;

    final manager = $$ThemeCatalogTableTableManager($_db, $_db.themeCatalog)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_catalogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EntriesTable, List<EntryRow>> _entriesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.entries,
          aliasName: 'daily_themes__id__entries__daily_theme_id');

  $$EntriesTableProcessedTableManager get entriesRefs {
    final manager = $$EntriesTableTableManager($_db, $_db.entries)
        .filter((f) => f.dailyThemeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DailyThemesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyThemesTable> {
  $$DailyThemesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get poeticPhrase => $composableBuilder(
      column: $table.poeticPhrase, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ThemeCatalogTableFilterComposer get catalogId {
    final $$ThemeCatalogTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.catalogId,
        referencedTable: $db.themeCatalog,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeCatalogTableFilterComposer(
              $db: $db,
              $table: $db.themeCatalog,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> entriesRefs(
      Expression<bool> Function($$EntriesTableFilterComposer f) f) {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entries,
        getReferencedColumn: (t) => t.dailyThemeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntriesTableFilterComposer(
              $db: $db,
              $table: $db.entries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DailyThemesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyThemesTable> {
  $$DailyThemesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get poeticPhrase => $composableBuilder(
      column: $table.poeticPhrase,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ThemeCatalogTableOrderingComposer get catalogId {
    final $$ThemeCatalogTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.catalogId,
        referencedTable: $db.themeCatalog,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeCatalogTableOrderingComposer(
              $db: $db,
              $table: $db.themeCatalog,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyThemesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyThemesTable> {
  $$DailyThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get poeticPhrase => $composableBuilder(
      column: $table.poeticPhrase, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ThemeCatalogTableAnnotationComposer get catalogId {
    final $$ThemeCatalogTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.catalogId,
        referencedTable: $db.themeCatalog,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ThemeCatalogTableAnnotationComposer(
              $db: $db,
              $table: $db.themeCatalog,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> entriesRefs<T extends Object>(
      Expression<T> Function($$EntriesTableAnnotationComposer a) f) {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entries,
        getReferencedColumn: (t) => t.dailyThemeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.entries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DailyThemesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyThemesTable,
    DailyThemeRow,
    $$DailyThemesTableFilterComposer,
    $$DailyThemesTableOrderingComposer,
    $$DailyThemesTableAnnotationComposer,
    $$DailyThemesTableCreateCompanionBuilder,
    $$DailyThemesTableUpdateCompanionBuilder,
    (DailyThemeRow, $$DailyThemesTableReferences),
    DailyThemeRow,
    PrefetchHooks Function({bool catalogId, bool entriesRefs})> {
  $$DailyThemesTableTableManager(_$AppDatabase db, $DailyThemesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> catalogId = const Value.absent(),
            Value<String> poeticPhrase = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              DailyThemesCompanion(
            id: id,
            date: date,
            catalogId: catalogId,
            poeticPhrase: poeticPhrase,
            createdAt: createdAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int catalogId,
            required String poeticPhrase,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              DailyThemesCompanion.insert(
            id: id,
            date: date,
            catalogId: catalogId,
            poeticPhrase: poeticPhrase,
            createdAt: createdAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DailyThemesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({catalogId = false, entriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (entriesRefs) db.entries],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (catalogId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.catalogId,
                    referencedTable:
                        $$DailyThemesTableReferences._catalogIdTable(db),
                    referencedColumn:
                        $$DailyThemesTableReferences._catalogIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entriesRefs)
                    await $_getPrefetchedData<DailyThemeRow, $DailyThemesTable,
                            EntryRow>(
                        currentTable: table,
                        referencedTable:
                            $$DailyThemesTableReferences._entriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DailyThemesTableReferences(db, table, p0)
                                .entriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.dailyThemeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DailyThemesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyThemesTable,
    DailyThemeRow,
    $$DailyThemesTableFilterComposer,
    $$DailyThemesTableOrderingComposer,
    $$DailyThemesTableAnnotationComposer,
    $$DailyThemesTableCreateCompanionBuilder,
    $$DailyThemesTableUpdateCompanionBuilder,
    (DailyThemeRow, $$DailyThemesTableReferences),
    DailyThemeRow,
    PrefetchHooks Function({bool catalogId, bool entriesRefs})>;
typedef $$EntriesTableCreateCompanionBuilder = EntriesCompanion Function({
  Value<int> id,
  required DateTime recordedAt,
  required String photoPath,
  required String extractedColorHex,
  required int dailyThemeId,
  Value<String?> memo,
  Value<double?> locationLat,
  Value<double?> locationLng,
  Value<bool> locationRecorded,
  Value<DateTime?> deletedAt,
});
typedef $$EntriesTableUpdateCompanionBuilder = EntriesCompanion Function({
  Value<int> id,
  Value<DateTime> recordedAt,
  Value<String> photoPath,
  Value<String> extractedColorHex,
  Value<int> dailyThemeId,
  Value<String?> memo,
  Value<double?> locationLat,
  Value<double?> locationLng,
  Value<bool> locationRecorded,
  Value<DateTime?> deletedAt,
});

final class $$EntriesTableReferences
    extends BaseReferences<_$AppDatabase, $EntriesTable, EntryRow> {
  $$EntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyThemesTable _dailyThemeIdTable(_$AppDatabase db) =>
      db.dailyThemes.createAlias('entries__daily_theme_id__daily_themes__id');

  $$DailyThemesTableProcessedTableManager get dailyThemeId {
    final $_column = $_itemColumn<int>('daily_theme_id')!;

    final manager = $$DailyThemesTableTableManager($_db, $_db.dailyThemes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyThemeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extractedColorHex => $composableBuilder(
      column: $table.extractedColorHex,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get locationRecorded => $composableBuilder(
      column: $table.locationRecorded,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$DailyThemesTableFilterComposer get dailyThemeId {
    final $$DailyThemesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dailyThemeId,
        referencedTable: $db.dailyThemes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyThemesTableFilterComposer(
              $db: $db,
              $table: $db.dailyThemes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extractedColorHex => $composableBuilder(
      column: $table.extractedColorHex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get locationRecorded => $composableBuilder(
      column: $table.locationRecorded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$DailyThemesTableOrderingComposer get dailyThemeId {
    final $$DailyThemesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dailyThemeId,
        referencedTable: $db.dailyThemes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyThemesTableOrderingComposer(
              $db: $db,
              $table: $db.dailyThemes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get extractedColorHex => $composableBuilder(
      column: $table.extractedColorHex, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<double> get locationLat => $composableBuilder(
      column: $table.locationLat, builder: (column) => column);

  GeneratedColumn<double> get locationLng => $composableBuilder(
      column: $table.locationLng, builder: (column) => column);

  GeneratedColumn<bool> get locationRecorded => $composableBuilder(
      column: $table.locationRecorded, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$DailyThemesTableAnnotationComposer get dailyThemeId {
    final $$DailyThemesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dailyThemeId,
        referencedTable: $db.dailyThemes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyThemesTableAnnotationComposer(
              $db: $db,
              $table: $db.dailyThemes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntriesTable,
    EntryRow,
    $$EntriesTableFilterComposer,
    $$EntriesTableOrderingComposer,
    $$EntriesTableAnnotationComposer,
    $$EntriesTableCreateCompanionBuilder,
    $$EntriesTableUpdateCompanionBuilder,
    (EntryRow, $$EntriesTableReferences),
    EntryRow,
    PrefetchHooks Function({bool dailyThemeId})> {
  $$EntriesTableTableManager(_$AppDatabase db, $EntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
            Value<String> photoPath = const Value.absent(),
            Value<String> extractedColorHex = const Value.absent(),
            Value<int> dailyThemeId = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<double?> locationLat = const Value.absent(),
            Value<double?> locationLng = const Value.absent(),
            Value<bool> locationRecorded = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              EntriesCompanion(
            id: id,
            recordedAt: recordedAt,
            photoPath: photoPath,
            extractedColorHex: extractedColorHex,
            dailyThemeId: dailyThemeId,
            memo: memo,
            locationLat: locationLat,
            locationLng: locationLng,
            locationRecorded: locationRecorded,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime recordedAt,
            required String photoPath,
            required String extractedColorHex,
            required int dailyThemeId,
            Value<String?> memo = const Value.absent(),
            Value<double?> locationLat = const Value.absent(),
            Value<double?> locationLng = const Value.absent(),
            Value<bool> locationRecorded = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              EntriesCompanion.insert(
            id: id,
            recordedAt: recordedAt,
            photoPath: photoPath,
            extractedColorHex: extractedColorHex,
            dailyThemeId: dailyThemeId,
            memo: memo,
            locationLat: locationLat,
            locationLng: locationLng,
            locationRecorded: locationRecorded,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EntriesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({dailyThemeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dailyThemeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dailyThemeId,
                    referencedTable:
                        $$EntriesTableReferences._dailyThemeIdTable(db),
                    referencedColumn:
                        $$EntriesTableReferences._dailyThemeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntriesTable,
    EntryRow,
    $$EntriesTableFilterComposer,
    $$EntriesTableOrderingComposer,
    $$EntriesTableAnnotationComposer,
    $$EntriesTableCreateCompanionBuilder,
    $$EntriesTableUpdateCompanionBuilder,
    (EntryRow, $$EntriesTableReferences),
    EntryRow,
    PrefetchHooks Function({bool dailyThemeId})>;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<bool> notificationEnabled,
  Value<String> notificationFrequency,
  Value<bool> locationFeatureEnabled,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<bool> notificationEnabled,
  Value<String> notificationFrequency,
  Value<bool> locationFeatureEnabled,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationEnabled => $composableBuilder(
      column: $table.notificationEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notificationFrequency => $composableBuilder(
      column: $table.notificationFrequency,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get locationFeatureEnabled => $composableBuilder(
      column: $table.locationFeatureEnabled,
      builder: (column) => ColumnFilters(column));
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationEnabled => $composableBuilder(
      column: $table.notificationEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notificationFrequency => $composableBuilder(
      column: $table.notificationFrequency,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get locationFeatureEnabled => $composableBuilder(
      column: $table.locationFeatureEnabled,
      builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get notificationEnabled => $composableBuilder(
      column: $table.notificationEnabled, builder: (column) => column);

  GeneratedColumn<String> get notificationFrequency => $composableBuilder(
      column: $table.notificationFrequency, builder: (column) => column);

  GeneratedColumn<bool> get locationFeatureEnabled => $composableBuilder(
      column: $table.locationFeatureEnabled, builder: (column) => column);
}

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    SettingsRow,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (SettingsRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingsRow>),
    SettingsRow,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationEnabled = const Value.absent(),
            Value<String> notificationFrequency = const Value.absent(),
            Value<bool> locationFeatureEnabled = const Value.absent(),
          }) =>
              SettingsCompanion(
            id: id,
            notificationEnabled: notificationEnabled,
            notificationFrequency: notificationFrequency,
            locationFeatureEnabled: locationFeatureEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationEnabled = const Value.absent(),
            Value<String> notificationFrequency = const Value.absent(),
            Value<bool> locationFeatureEnabled = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            id: id,
            notificationEnabled: notificationEnabled,
            notificationFrequency: notificationFrequency,
            locationFeatureEnabled: locationFeatureEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    SettingsRow,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (SettingsRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingsRow>),
    SettingsRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ThemeCatalogTableTableManager get themeCatalog =>
      $$ThemeCatalogTableTableManager(_db, _db.themeCatalog);
  $$DailyThemesTableTableManager get dailyThemes =>
      $$DailyThemesTableTableManager(_db, _db.dailyThemes);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db, _db.entries);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
