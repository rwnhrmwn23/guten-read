import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenread/routes/app_router.dart';
import 'package:gutenread/shared/constants/text_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final hasFinished = prefs.getBool('hasFinishedOnboarding') ?? false;

  final router = createRouter(hasFinishedOnboarding: hasFinished);

  runApp(ProviderScope(child: MyApp(router: router)));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

