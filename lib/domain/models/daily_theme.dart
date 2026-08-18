import 'theme_catalog_entry.dart';

class DailyTheme {
  const DailyTheme({
    required this.id,
    required this.date,
    required this.catalog,
    required this.poeticPhrase,
  });

  final int id;
  final DateTime date;

  /// JOIN済みのお題カタログ内容。
  final ThemeCatalogEntry catalog;

  /// その日確定した添え文言（不変）。
  final String poeticPhrase;
}

class ThemePage {
  const ThemePage({required this.items, required this.hasMore});

  final List<DailyTheme> items;

  /// さらに古いページが存在するか。
  final bool hasMore;
}
