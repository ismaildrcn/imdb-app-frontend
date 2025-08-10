import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/theme.dart';
import 'package:imdb_app/app/theme_manager.dart';
import 'package:imdb_app/features/profile/utils/auth_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");
  final authProvider = AuthProvider();
  await authProvider.checkAuthStatus(); // Auth durumunu kontrol et

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider(create: (context) => ThemeManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'IMDB',
      theme: AppTheme.lightTheme, // Light tema
      darkTheme: AppTheme.darkTheme, // Dark tema
      themeMode: themeManager.themeMode, // Dinamik tema modu
      routerConfig: AppRouter(authProvider).router,
    );
  }
}
