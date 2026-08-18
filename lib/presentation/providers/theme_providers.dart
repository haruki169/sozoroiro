import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/repositories/theme_repository.dart';
import '../../data/services/location_service.dart';
import '../../data/services/weather_service.dart';
import '../../domain/models/daily_theme.dart';
import '../../domain/usecases/theme_selector.dart';
import 'settings_providers.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return ThemeRepository(ref.watch(appDatabaseProvider));
});

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final themeSelectorProvider = Provider<ThemeSelector>((ref) {
  return ThemeSelector(
    ref.watch(themeRepositoryProvider),
    ref.watch(weatherServiceProvider),
    ref.watch(locationServiceProvider),
  );
});

/// アプリ起動時にお題カタログ(60件)をseedする。
final catalogSeedProvider = FutureProvider<void>((ref) async {
  await ref.watch(themeRepositoryProvider).seedCatalogIfEmpty();
});

final todayThemeProvider = FutureProvider.autoDispose<DailyTheme>((
  ref,
) async {
  await ref.watch(catalogSeedProvider.future);
  final settings = await ref.watch(settingsProvider.future);
  final selector = ref.watch(themeSelectorProvider);
  return selector.getOrCreateTheme(
    locationFeatureEnabled: settings.locationFeatureEnabled,
  );
});

final dailyThemeByIdProvider = FutureProvider.autoDispose
    .family<DailyTheme?, int>((ref, dailyThemeId) async {
      return ref.watch(themeRepositoryProvider).findById(dailyThemeId);
    });

final pastThemesProvider = FutureProvider.autoDispose
    .family<ThemePage, int>((ref, page) async {
      await ref.watch(catalogSeedProvider.future);
      final selector = ref.watch(themeSelectorProvider);
      return selector.fetchPastThemes(page: page);
    });
