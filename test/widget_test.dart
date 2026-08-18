import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:sozoroiro/app.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ja_JP');
  });

  testWidgets('SozoroiroApp launches and shows the home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: SozoroiroApp()),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('そぞろいろ'), findsWidgets);

    // Driftのストリーム購読が非同期タイマーを残したままテストが終わると
    // flutter_testのpending-timer検知に引っかかるため、破棄前にフラッシュする。
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
