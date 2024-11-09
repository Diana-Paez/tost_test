import 'package:flutter/material.dart';
import 'package:flutter_test_tots/app/app.router.dart';
import 'package:flutter_test_tots/app/app.locator.dart';
import 'package:flutter_test_tots/app/core/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Material App',
      navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
      initialRoute: AppRouter.loginRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
