import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// #RRGGBB文字列を色として表示する丸いスウォッチ。
/// colorHexがnullの場合はプレースホルダー（グレー）を表示する
/// （抽出失敗時のフォールバック、design.md 7.2節）。
class ColorDot extends StatelessWidget {
  const ColorDot({super.key, required this.colorHex, this.size = 64});

  final String? colorHex;
  final double size;

  Color? get _color {
    final hex = colorHex;
    if (hex == null) return null;
    final normalized = hex.replaceFirst('#', '');
    final value = int.tryParse(normalized, radix: 16);
    if (value == null) return null;
    return Color(0xFF000000 | value);
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: color == null
          ? Icon(
              Icons.palette_outlined,
              size: size * 0.4,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            )
          : null,
    );
  }
}

/// 角丸カード共通ラッパー。
class SoftCard extends StatelessWidget {
  const SoftCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: child,
    );
  }
}
