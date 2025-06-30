import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenread/routes/app_router.dart';
import 'package:gutenread/shared/constants/text_constant.dart';
import 'package:gutenread/utils/network_checker.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkChecker.startListening();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routeProvider);
    return MaterialApp.router(
      title: appName,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

