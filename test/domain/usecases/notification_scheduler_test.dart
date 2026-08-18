import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sozoroiro/data/db/app_database.dart';
import 'package:sozoroiro/data/repositories/settings_repository.dart';
import 'package:sozoroiro/data/services/notification_service.dart';
import 'package:sozoroiro/domain/models/app_settings.dart';
import 'package:sozoroiro/domain/usecases/notification_scheduler.dart';

class _FakeNotificationService extends NotificationService {
  final List<DateTime> scheduledTimes = [];
  int cancelCount = 0;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> scheduleAt(
    DateTime dateTime, {
    required String title,
    required String body,
    int id = 0,
  }) async {
    scheduledTimes.add(dateTime);
  }

  @override
  Future<void> cancelAll() async {
    cancelCount++;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late SettingsRepository settingsRepository;
  late _FakeNotificationService fakeService;
  late NotificationScheduler scheduler;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    settingsRepository = SettingsRepository(db);
    fakeService = _FakeNotificationService();
    scheduler = NotificationScheduler(
      settingsRepository,
      notificationService: fakeService,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('off設定では通知をスケジュールしない', () async {
    await settingsRepository.update(
      const AppSettings(
        notificationEnabled: true,
        notificationFrequency: NotificationFrequency.off,
        locationFeatureEnabled: false,
      ),
    );

    await scheduler.rescheduleFromSettings();

    expect(fakeService.cancelCount, 1);
    expect(fakeService.scheduledTimes, isEmpty);
  });

  test('daily設定では毎日8:00〜21:00の間で1件ずつスケジュールされる', () async {
    await settingsRepository.update(
      const AppSettings(
        notificationEnabled: true,
        notificationFrequency: NotificationFrequency.daily,
        locationFeatureEnabled: false,
      ),
    );

    await scheduler.rescheduleFromSettings();

    expect(fakeService.scheduledTimes, isNotEmpty);
    for (final time in fakeService.scheduledTimes) {
      expect(time.hour >= 8 && time.hour < 21, isTrue);
    }
  });

  test('occasionally設定では9:00〜20:00の間でスケジュールされ、24時間以上間隔が空く', () async {
    await settingsRepository.update(
      const AppSettings(
        notificationEnabled: true,
        notificationFrequency: NotificationFrequency.occasionally,
        locationFeatureEnabled: false,
      ),
    );

    await scheduler.rescheduleFromSettings();

    expect(fakeService.scheduledTimes, isNotEmpty);
    for (final time in fakeService.scheduledTimes) {
      expect(time.hour >= 9 && time.hour < 20, isTrue);
    }
    final sorted = [...fakeService.scheduledTimes]..sort();
    for (var i = 1; i < sorted.length; i++) {
      expect(
        sorted[i].difference(sorted[i - 1]) >= const Duration(hours: 24),
        isTrue,
      );
    }
  });

  test('notificationEnabled=falseの場合はスケジュールしない', () async {
    await settingsRepository.update(
      const AppSettings(
        notificationEnabled: false,
        notificationFrequency: NotificationFrequency.daily,
        locationFeatureEnabled: false,
      ),
    );

    await scheduler.rescheduleFromSettings();

    expect(fakeService.scheduledTimes, isEmpty);
  });
}
