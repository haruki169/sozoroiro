/// 季節タグ判定ロジック（design.md 4.5節・5.2節）。
enum Season {
  spring,
  summer,
  autumn,
  winter;

  /// design.mdのタグ語彙に合わせた文字列表現。
  String get tag => name;

  /// 指定日時（省略時は現在時刻）から日本の季節感に沿って季節を判定する。
  /// 3-5月: 春 / 6-8月: 夏 / 9-11月: 秋 / 12-2月: 冬
  static Season fromDate(DateTime date) {
    final month = date.month;
    if (month >= 3 && month <= 5) return Season.spring;
    if (month >= 6 && month <= 8) return Season.summer;
    if (month >= 9 && month <= 11) return Season.autumn;
    return Season.winter;
  }

  static Season current() => fromDate(DateTime.now());
}
