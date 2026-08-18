import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../providers/theme_providers.dart';
import '../../widgets/color_swatch.dart';
import '../../widgets/theme_picker_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayThemeAsync = ref.watch(todayThemeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('そぞろいろ')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('yyyy年M月d日 (E)', 'ja').format(DateTime.now()),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: Center(
                  child: todayThemeAsync.when(
                    data: (theme) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ColorDot(colorHex: theme.catalog.colorHex, size: 120),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          theme.catalog.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          theme.poeticPhrase,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    loading: () => const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ],
                    ),
                    error: (error, stack) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '少し時間をおいてもう一度お試しください。',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        OutlinedButton(
                          onPressed: () => ref.invalidate(todayThemeProvider),
                          child: const Text('もう一度読み込む'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: todayThemeAsync.maybeWhen(
                  data: (theme) => () =>
                      context.push('/record', extra: theme.id),
                  orElse: () => null,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Text('色を見つけたら記録する'),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => ThemePickerSheet(
                      onSelected: (theme) =>
                          context.push('/record', extra: theme.id),
                    ),
                  );
                },
                child: const Text('気になる色をもう一度探す'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
