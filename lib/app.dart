import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'presentation/screens/record/record_screen.dart';
import 'presentation/screens/root_scaffold.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootScaffold(),
    ),
    GoRoute(
      path: '/record',
      builder: (context, state) {
        final dailyThemeId = state.extra as int;
        return RecordScreen(dailyThemeId: dailyThemeId);
      },
    ),
  ],
);

class SozoroiroApp extends StatelessWidget {
  const SozoroiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'そぞろいろ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
