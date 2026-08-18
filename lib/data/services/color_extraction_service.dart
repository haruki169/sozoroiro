import 'dart:io';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// 写真からの代表色抽出（tech-stack.md 2章：オンデバイス処理、palette_generatorを利用）。
class ColorExtractionService {
  /// 画像ファイルからドミナントカラーを抽出し、#RRGGBB形式で返す。
  /// 抽出に失敗した場合はnullを返し、呼び出し側でフォールバック表示を行う。
  Future<String?> extractDominantColorHex(File imageFile) async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        FileImage(imageFile),
        maximumColorCount: 16,
      );
      final color =
          palette.dominantColor?.color ??
          palette.vibrantColor?.color ??
          palette.mutedColor?.color;
      if (color == null) return null;
      return colorToHex(color);
    } catch (_) {
      return null;
    }
  }

  static String colorToHex(Color color) {
    final r = (color.r * 255).round().clamp(0, 255);
    final g = (color.g * 255).round().clamp(0, 255);
    final b = (color.b * 255).round().clamp(0, 255);
    return '#${r.toRadixString(16).padLeft(2, '0')}'
            '${g.toRadixString(16).padLeft(2, '0')}'
            '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}
