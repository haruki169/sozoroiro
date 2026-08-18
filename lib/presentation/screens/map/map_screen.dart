import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/models/entry.dart';
import '../../providers/entry_providers.dart';
import '../../widgets/color_swatch.dart';

/// MapTiler CloudのAPIキー。`--dart-define=MAPTILER_API_KEY=xxxx`でビルド時に注入する
/// （tech-stack.md 4章確定事項。ハードコード禁止）。T-023でユーザーが取得したキーを設定する。
const _mapTilerApiKey = String.fromEnvironment('MAPTILER_API_KEY');

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(locatedEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('色の地図')),
      body: SafeArea(
        child: entriesAsync.when(
          data: (entries) {
            if (_mapTilerApiKey.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    '地図タイルの表示にはMapTiler CloudのAPIキーが必要です。'
                    '取得後、--dart-define=MAPTILER_API_KEY=... を指定してビルドしてください。',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (entries.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Text('まだ地図に記録はありません。'),
                ),
              );
            }

            final center = LatLng(
              entries.first.locationLat!,
              entries.first.locationLng!,
            );

            return FlutterMap(
              options: MapOptions(initialCenter: center, initialZoom: 12),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=$_mapTilerApiKey',
                  userAgentPackageName: 'com.example.sozoroiro',
                  errorTileCallback: (tile, error, stackTrace) {},
                ),
                MarkerLayer(
                  markers: [
                    for (final entry in entries)
                      Marker(
                        point: LatLng(
                          entry.locationLat!,
                          entry.locationLng!,
                        ),
                        width: 32,
                        height: 32,
                        child: GestureDetector(
                          onTap: () => _showEntryPopup(context, entry),
                          child: ColorDot(
                            colorHex: entry.extractedColorHex,
                            size: 28,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('地図を表示できませんでした。他の機能には影響ありません。'),
            ),
          ),
        ),
      ),
    );
  }

  void _showEntryPopup(BuildContext context, Entry entry) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            ColorDot(colorHex: entry.extractedColorHex, size: 48),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.dailyTheme.catalog.name),
                  Text('${entry.recordedAt}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
