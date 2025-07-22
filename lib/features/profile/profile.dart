import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/theme_manager.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: topNavBar(context, "Profile"),
      body: SafeArea(
        child: SwitchListTile(
          value: isDarkMode,
          title: Text("Dark Mode"),
          onChanged: (value) {
            themeManager.toggleTheme(value);
          },
        ),
      ),
    );
  }
}
