/// Open-MeteoのWMO Weather Interpretation Codeから、内部weatherTagへの変換。
/// design.md 4.5節のマッピング表に対応する（確定仕様）。
class WeatherTagMapper {
  WeatherTagMapper._();

  static const List<int> _sunny = [0, 1];
  static const List<int> _cloudy = [2, 3];
  static const List<int> _rain = [
    51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82,
  ];
  static const List<int> _snow = [71, 73, 75, 77, 85, 86];
  static const List<int> _fog = [45, 48];
  static const List<int> _thunder = [95, 96, 99];

  /// WMOコードから内部weatherTagへ変換する。未知のコードはnullを返す。
  static String? fromWmoCode(int code) {
    if (_sunny.contains(code)) return 'sunny';
    if (_cloudy.contains(code)) return 'cloudy';
    if (_rain.contains(code)) return 'rain';
    if (_snow.contains(code)) return 'snow';
    if (_fog.contains(code)) return 'fog';
    if (_thunder.contains(code)) return 'thunder';
    return null;
  }
}
