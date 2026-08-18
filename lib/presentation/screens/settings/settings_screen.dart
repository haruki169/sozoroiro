import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/models/app_settings.dart';
import '../../providers/entry_providers.dart';
import '../../providers/settings_providers.dart';
import '../../providers/theme_providers.dart';
import '../../widgets/color_swatch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _updateAndReschedule(
    WidgetRef ref,
    AppSettings newSettings,
  ) async {
    await ref.read(settingsRepositoryProvider).update(newSettings);
    await ref.read(notificationSchedulerProvider).rescheduleFromSettings();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SafeArea(
        child: settingsAsync.when(
          data: (settings) => ListView(
            children: [
              SwitchListTile(
                title: const Text('通知'),
                value: settings.notificationEnabled,
                onChanged: (value) => _updateAndReschedule(
                  ref,
                  settings.copyWith(notificationEnabled: value),
                ),
              ),
              ListTile(
                title: const Text('通知の頻度'),
                trailing: DropdownButton<NotificationFrequency>(
                  value: settings.notificationFrequency,
                  onChanged: settings.notificationEnabled
                      ? (value) {
                          if (value == null) return;
                          _updateAndReschedule(
                            ref,
                            settings.copyWith(notificationFrequency: value),
                          );
                        }
                      : null,
                  items: const [
                    DropdownMenuItem(
                      value: NotificationFrequency.off,
                      child: Text('オフ'),
                    ),
                    DropdownMenuItem(
                      value: NotificationFrequency.occasionally,
                      child: Text('たまに'),
                    ),
                    DropdownMenuItem(
                      value: NotificationFrequency.daily,
                      child: Text('毎日'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('位置情報を利用する'),
                subtitle: const Text('オフでも他の機能に支障はありません'),
                value: settings.locationFeatureEnabled,
                onChanged: (value) => _updateAndReschedule(
                  ref,
                  settings.copyWith(locationFeatureEnabled: value),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('データのエクスポート'),
                leading: const Icon(Icons.ios_share_outlined),
                onTap: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    await ref.read(exportServiceProvider).exportAndShare();
                  } catch (_) {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          'エクスポートできませんでした。少し時間をおいてもう一度お試しください。',
                        ),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: const Text('お題一覧の閲覧'),
                leading: const Icon(Icons.palette_outlined),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ThemeCatalogListScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              const _AboutTile(),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) =>
              const Center(child: Text('設定を読み込めませんでした。')),
        ),
      ),
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data == null
            ? ''
            : '${snapshot.data!.version} (${snapshot.data!.buildNumber})';
        return ListTile(
          title: const Text('アプリについて'),
          subtitle: Text('そぞろいろ $version'),
          leading: const Icon(Icons.info_outline),
        );
      },
    );
  }
}

class ThemeCatalogListScreen extends ConsumerWidget {
  const ThemeCatalogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(themeRepositoryProvider).fetchAllCatalog();

    return Scaffold(
      appBar: AppBar(title: const Text('お題一覧')),
      body: FutureBuilder(
        future: catalogAsync,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final catalog = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.sm),
            itemCount: catalog.length,
            itemBuilder: (context, index) {
              final entry = catalog[index];
              return ListTile(
                leading: ColorDot(colorHex: entry.colorHex, size: 36),
                title: Text(entry.name),
              );
            },
          );
        },
      ),
    );
  }
}
