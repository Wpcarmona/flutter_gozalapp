

import 'package:flutter/material.dart';
import 'package:gozalapp/config/router/app_router.dart';
import 'package:gozalapp/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future <void> main() async {

  await dotenv.load(fileName: ".env"); 
  runApp(
    ProviderScope(
      child: const MyApp(),
    )
  );
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'GozalApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}