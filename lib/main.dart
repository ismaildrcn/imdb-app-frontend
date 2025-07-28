import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/theme.dart';
import 'package:imdb_app/app/theme_manager.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeManager(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'IMDB',
      theme: AppTheme.lightTheme, // Light tema
      darkTheme: AppTheme.darkTheme, // Dark tema
      themeMode: themeManager.themeMode, // Dinamik tema modu
      routerConfig: appRoutes,
    );
  }
}
