import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'IMDB',
      theme: AppTheme.lightTheme,
      routerConfig: appRoutes,
    );
  }
}
