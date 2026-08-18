import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/models/entry.dart';
import 'color_swatch.dart';

/// 直近1週間分の記録色を並べたグラデーションリボン（要件定義書5.3、6章Should）。
class GradientRibbon extends StatelessWidget {
  const GradientRibbon({super.key, required this.entries});

  final List<Entry> entries;

  Color? _parseColor(String hex) {
    final normalized = hex.replaceFirst('#', '');
    final value = int.tryParse(normalized, radix: 16);
    if (value == null) return null;
    return Color(0xFF000000 | value);
  }

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return SoftCard(
        child: Text(
          'まだ直近の記録がありません。色を見つけたら、ここに並んでいきます。',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    final colors = entries
        .map((e) => _parseColor(e.extractedColorHex))
        .whereType<Color>()
        .toList();
    if (colors.length == 1) {
      colors.add(colors.first);
    }

    return Container(
      height: 48,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}
