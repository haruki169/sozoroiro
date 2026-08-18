/// design.md 4.5節の内部weatherTag（sunny/cloudy/rain/snow/fog/thunder）を保持する。
class WeatherCondition {
  const WeatherCondition({required this.tag});

  final String tag;
}
