import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:sozoroiro/data/services/color_extraction_service.dart';

/// 明るい写真・暗い写真・彩度の低い写真を模した合成画像でドミナントカラー抽出を検証する（T-003）。
/// 実機カメラ画像での追加検証は、実装後の実機テスト（T-022）で行う。
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final service = ColorExtractionService();
  late Directory tempDir;

  setUpAll(() {
    tempDir = Directory.systemTemp.createTempSync('color_extraction_test');
  });

  tearDownAll(() {
    tempDir.deleteSync(recursive: true);
  });

  File writeSolidColorImage(String name, int r, int g, int b) {
    final image = img.Image(width: 64, height: 64);
    img.fill(image, color: img.ColorRgb8(r, g, b));
    final bytes = img.encodePng(image);
    final file = File(p.join(tempDir.path, name));
    file.writeAsBytesSync(bytes);
    return file;
  }

  test('明るい写真（暖色）から妥当な代表色を抽出できる', () async {
    final file = writeSolidColorImage('bright.png', 245, 196, 90); // 麦わら帽子色相当
    final hex = await service.extractDominantColorHex(file);

    expect(hex, isNotNull);
    expect(hex, matches(RegExp(r'^#[0-9A-F]{6}$')));
  });

  test('暗い写真（濃紺）から妥当な代表色を抽出できる', () async {
    final file = writeSolidColorImage('dark.png', 31, 43, 74); // 冬の澄んだ夜空色相当
    final hex = await service.extractDominantColorHex(file);

    expect(hex, isNotNull);
    expect(hex, matches(RegExp(r'^#[0-9A-F]{6}$')));
  });

  test('彩度の低い写真（グレー系）から妥当な代表色を抽出できる', () async {
    final file = writeSolidColorImage('low_saturation.png', 150, 150, 148);
    final hex = await service.extractDominantColorHex(file);

    expect(hex, isNotNull);
    expect(hex, matches(RegExp(r'^#[0-9A-F]{6}$')));
  });

  test('壊れた画像ファイルの場合はnullを返し、例外を投げない（フォールバック方針）', () async {
    final file = File(p.join(tempDir.path, 'broken.png'));
    file.writeAsBytesSync([0x00, 0x01, 0x02]);

    final hex = await service.extractDominantColorHex(file);
    expect(hex, isNull);
  });
}
