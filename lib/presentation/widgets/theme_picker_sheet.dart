import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/models/daily_theme.dart';
import '../providers/theme_providers.dart';
import 'color_swatch.dart';

/// 過去のお題選択シート（design.md 6.1節）。
/// pastThemesProvider(page)を用いて2週間単位でページネーション表示する。
class ThemePickerSheet extends ConsumerStatefulWidget {
  const ThemePickerSheet({super.key, required this.onSelected});

  final void Function(DailyTheme theme) onSelected;

  @override
  ConsumerState<ThemePickerSheet> createState() => _ThemePickerSheetState();
}

class _ThemePickerSheetState extends ConsumerState<ThemePickerSheet> {
  int _pageCount = 1;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              Text(
                '気になる色をもう一度探す',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _pageCount + 1,
                  itemBuilder: (context, pageIndex) {
                    if (pageIndex == _pageCount) {
                      return _LoadMoreOrEnd(
                        page: _pageCount - 1,
                        onLoadMore: () => setState(() => _pageCount++),
                      );
                    }
                    return _ThemePageList(
                      page: pageIndex,
                      onSelected: widget.onSelected,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemePageList extends ConsumerWidget {
  const _ThemePageList({required this.page, required this.onSelected});

  final int page;
  final void Function(DailyTheme theme) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageAsync = ref.watch(pastThemesProvider(page));
    return pageAsync.when(
      data: (themePage) => Column(
        children: [
          for (final theme in themePage.items)
            ListTile(
              leading: ColorDot(colorHex: theme.catalog.colorHex, size: 40),
              title: Text(theme.catalog.name),
              subtitle: Text(DateFormat('yyyy/MM/dd').format(theme.date)),
              onTap: () {
                Navigator.of(context).pop();
                onSelected(theme);
              },
            ),
        ],
      ),
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Text('お題を読み込めませんでした。少し時間をおいてもう一度お試しください。'),
      ),
    );
  }
}

class _LoadMoreOrEnd extends ConsumerWidget {
  const _LoadMoreOrEnd({required this.page, required this.onLoadMore});

  final int page;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageAsync = ref.watch(pastThemesProvider(page));
    return pageAsync.maybeWhen(
      data: (themePage) {
        if (!themePage.hasMore) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Center(
            child: TextButton(onPressed: onLoadMore, child: const Text('もっと見る')),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
