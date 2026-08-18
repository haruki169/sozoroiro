import 'dart:math';

import '../../data/repositories/settings_repository.dart';
import '../../data/services/notification_service.dart';
import '../models/app_settings.dart';

/// 通知スケジューリング（要件定義書4章・8章「催促ではなく誘い」、design.md 5.3節）。
class NotificationScheduler {
  NotificationScheduler(
    this._settingsRepository, {
    NotificationService? notificationService,
    Random? random,
  }) : _notificationService = notificationService ?? NotificationService(),
       _random = random ?? Random();

  final SettingsRepository _settingsRepository;
  final NotificationService _notificationService;
  final Random _random;

  static const _scheduleHorizonDays = 14;

  static const List<String> _invitationPhrases = [
    'そぞろ歩きの途中で、気になる色はありましたか。',
    'ふと目にとまる色が、今日はあるかもしれません。',
    '色を探しに、少しだけ外を歩いてみませんか。',
    '今日のお題、まだのぞいていないなら、いつでもどうぞ。',
    '急がなくて大丈夫です。気が向いたときに。',
  ];

  /// 現在の設定（頻度・ON/OFF）に基づき、以後の通知を再スケジュールする。
  Future<void> rescheduleFromSettings() async {
    await _notificationService.cancelAll();

    final settingsStream = _settingsRepository.watchSettings();
    final settings = await settingsStream.first;

    if (!settings.notificationEnabled ||
        settings.notificationFrequency == NotificationFrequency.off) {
      return;
    }

    final times = switch (settings.notificationFrequency) {
      NotificationFrequency.daily => _buildDailySchedule(),
      NotificationFrequency.occasionally => _buildOccasionallySchedule(),
      NotificationFrequency.off => <DateTime>[],
    };

    var id = 0;
    for (final time in times) {
      if (time.isBefore(DateTime.now())) continue;
      await _notificationService.scheduleAt(
        time,
        title: 'そぞろいろ',
        body: _invitationPhrases[_random.nextInt(_invitationPhrases.length)],
        id: id++,
      );
    }
  }

  Future<void> cancelAll() => _notificationService.cancelAll();

  /// 1日1回、8:00〜21:00の間でランダムな時刻に配信。
  List<DateTime> _buildDailySchedule() {
    final now = DateTime.now();
    return List.generate(_scheduleHorizonDays, (i) {
      final day = DateTime(now.year, now.month, now.day + i);
      return _randomTimeOnDay(day, startHour: 8, endHour: 21);
    });
  }

  /// 週2〜3回、9:00〜20:00の間でランダムな時刻に配信。前回通知から最低24時間間隔を空ける。
  List<DateTime> _buildOccasionallySchedule() {
    final now = DateTime.now();
    final result = <DateTime>[];
    DateTime? previous;

    final weekCount = (_scheduleHorizonDays / 7).ceil();
    for (var week = 0; week < weekCount; week++) {
      final timesThisWeek = 2 + _random.nextInt(2); // 2〜3回
      final usedDays = <int>{};
      var attempts = 0;
      while (usedDays.length < timesThisWeek && attempts < 20) {
        attempts++;
        final dayOffset = week * 7 + _random.nextInt(7);
        if (dayOffset >= _scheduleHorizonDays) continue;
        if (usedDays.contains(dayOffset)) continue;

        final day = DateTime(now.year, now.month, now.day + dayOffset);
        final candidate = _randomTimeOnDay(day, startHour: 9, endHour: 20);
        if (previous != null &&
            candidate.difference(previous).abs() <
                const Duration(hours: 24)) {
          continue;
        }
        usedDays.add(dayOffset);
        result.add(candidate);
        previous = candidate;
      }
    }
    result.sort();
    return result;
  }

  DateTime _randomTimeOnDay(
    DateTime day, {
    required int startHour,
    required int endHour,
  }) {
    final minutesRange = (endHour - startHour) * 60;
    final offsetMinutes = _random.nextInt(minutesRange);
    return DateTime(
      day.year,
      day.month,
      day.day,
      startHour,
    ).add(Duration(minutes: offsetMinutes));
  }
}
