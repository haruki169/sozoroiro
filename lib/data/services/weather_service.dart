import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/utils/weather_tag_mapper.dart';
import '../../domain/models/weather_condition.dart';

/// 天気情報取得（Open-Meteo、APIキー不要）。design.md 5.4節。
class WeatherService {
  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _timeout = Duration(seconds: 8);

  /// 緯度経度から天気を取得し、weatherTagに変換して返す。
  /// ネットワークエラー・タイムアウト・位置情報なしの場合は例外を握りつぶしnullを返す
  /// （呼び出し側は季節のみにフォールバック。tech-stack.md 8.1で確定）。
  Future<WeatherCondition?> fetchCurrentCondition({
    required double lat,
    required double lng,
  }) async {
    try {
      final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': lat.toString(),
        'longitude': lng.toString(),
        'current': 'weather_code',
      });
      final response = await _client.get(uri).timeout(_timeout);
      if (response.statusCode != 200) return null;

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final current = body['current'] as Map<String, dynamic>?;
      final code = current?['weather_code'];
      if (code is! num) return null;

      final tag = WeatherTagMapper.fromWmoCode(code.toInt());
      if (tag == null) return null;
      return WeatherCondition(tag: tag);
    } catch (_) {
      return null;
    }
  }
}
