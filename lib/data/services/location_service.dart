import 'package:geolocator/geolocator.dart';

/// 位置情報取得（geolocatorラップ）。要件5.2トグル・8章プライバシー対応。
class LocationService {
  /// userToggleOnがfalseの場合はgeolocatorを一切呼び出さずnullを返す。
  /// パーミッション拒否・取得失敗時も例外を投げずnullを返す。
  Future<Position?> getCurrentPositionIfEnabled(bool userToggleOn) async {
    if (!userToggleOn) return null;

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.reduced,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (_) {
      return null;
    }
  }
}
