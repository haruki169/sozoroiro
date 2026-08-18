import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../providers/entry_providers.dart';
import '../../widgets/color_swatch.dart';
import '../../widgets/gradient_ribbon.dart';

enum DiaryViewMode { list, ribbon }

final diaryViewModeProvider = StateProvider<DiaryViewMode>(
  (ref) => DiaryViewMode.list,
);

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineAsync = ref.watch(timelineProvider);
    final viewMode = ref.watch(diaryViewModeProvider);
    final ribbonEntriesAsync = ref.watch(ribbonEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('色の日記')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ribbonEntriesAsync.when(
                data: (entries) => GradientRibbon(entries: entries),
                loading: () => const SizedBox(
                  height: 48,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                error: (e, s) => const SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              child: SegmentedButton<DiaryViewMode>(
                segments: const [
                  ButtonSegment(
                    value: DiaryViewMode.list,
                    label: Text('リスト'),
                    icon: Icon(Icons.view_list_outlined),
                  ),
                  ButtonSegment(
                    value: DiaryViewMode.ribbon,
                    label: Text('リボン'),
                    icon: Icon(Icons.gradient_outlined),
                  ),
                ],
                selected: {viewMode},
                onSelectionChanged: (selection) => ref
                    .read(diaryViewModeProvider.notifier)
                    .state = selection.first,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: timelineAsync.when(
                data: (entries) {
                  if (entries.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        child: Text('まだ記録がありません。色を見つけたら、ここに並んでいきます。'),
                      ),
                    );
                  }
                  if (viewMode == DiaryViewMode.ribbon) {
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: GradientRibbon(entries: entries),
                    );
                  }
                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return ListTile(
                        leading: ColorDot(
                          colorHex: entry.extractedColorHex,
                          size: 40,
                        ),
                        title: Text(entry.dailyTheme.catalog.name),
                        subtitle: Text(
                          [
                            DateFormat(
                              'yyyy/MM/dd HH:mm',
                            ).format(entry.recordedAt),
                            if (entry.memo != null && entry.memo!.isNotEmpty)
                              entry.memo!,
                          ].join(' ・ '),
                        ),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, s) => const Center(
                  child: Text('読み込めませんでした。少し時間をおいてもう一度お試しください。'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
