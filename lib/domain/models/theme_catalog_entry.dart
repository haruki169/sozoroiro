class ThemeCatalogEntry {
  const ThemeCatalogEntry({
    required this.id,
    required this.catalogKey,
    required this.name,
    required this.colorHex,
    required this.seasonTags,
    required this.weatherTags,
    required this.poeticPhrases,
  });

  final int id;
  final String catalogKey;
  final String name;
  final String colorHex;
  final List<String> seasonTags;

  /// design.md 4.5節の6種の内部タグ語彙のいずれか、または天気非依存を表す空配列。
  final List<String> weatherTags;
  final List<String> poeticPhrases;
}
