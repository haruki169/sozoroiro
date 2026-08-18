import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sozoroiro/data/db/app_database.dart';
import 'package:sozoroiro/data/repositories/theme_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ThemeRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = ThemeRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('seedCatalogIfEmpty inserts 60 entries from asset json', () async {
    await repository.seedCatalogIfEmpty();

    final all = await repository.fetchAllCatalog();
    expect(all.length, 60);
    expect(all.every((e) => e.poeticPhrases.isNotEmpty), isTrue);
  });

  test('seedCatalogIfEmpty is idempotent (does not duplicate)', () async {
    await repository.seedCatalogIfEmpty();
    await repository.seedCatalogIfEmpty();

    final all = await repository.fetchAllCatalog();
    expect(all.length, 60);
  });
}
