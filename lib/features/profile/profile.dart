import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/features/profile/utils/auth_provider.dart';
import 'package:imdb_app/features/profile/utils/storage.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: Column(
            spacing: 20,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 86,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: BoxBorder.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(128),
                    width: 2,
                    style: BorderStyle.solid,
                    strokeAlign: 0.7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(
                        64,
                      ), // Gölge rengi ve opaklık
                      blurRadius: 5, // Gölge yumuşaklığı
                      spreadRadius: 1, // Gölge yayılması
                      offset: Offset(0, 2), // Gölge pozisyonu (x, y)
                    ),
                  ],
                ),
                child: Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      foregroundImage: AssetImage(
                        "assets/img/ismail-durcan.jpg",
                      ),
                      radius: 40,
                      child: Icon(Icons.person),
                    ),
                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "İsmail DURCAN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "ismailonlycoder@gmail.com",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ],
                ),
              ),

              // Account Area
              Container(
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: BoxBorder.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(128),
                    width: 2,
                    style: BorderStyle.solid,
                    strokeAlign: 0.7,
                  ),
                ),
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8),
                    subProfileContent(
                      context,
                      title: "Member",
                      icon: Icons.person_pin_rounded,
                      onTap: () {},
                      iconColor: Theme.of(context).colorScheme.primary,
                    ),
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      thickness: 1.5,
                    ),
                    subProfileContent(
                      context,
                      title: "Change Password",
                      icon: Icons.lock,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // General Area
              Container(
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: BoxBorder.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(128),
                    width: 2,
                    style: BorderStyle.solid,
                    strokeAlign: 0.7,
                  ),
                ),
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "General",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8),
                    subProfileContent(
                      context,
                      title: "Notifications",
                      icon: Icons.notifications,
                      onTap: () {},
                    ),
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      thickness: 1.5,
                    ),
                    subProfileContent(
                      context,
                      title: "Language",
                      icon: Icons.language,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // More Area
              Container(
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: BoxBorder.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(128),
                    width: 2,
                    style: BorderStyle.solid,
                    strokeAlign: 0.7,
                  ),
                ),
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8),
                    subProfileContent(
                      context,
                      title: "Conditions of Use",
                      icon: Icons.notifications,
                      onTap: () => context.push(
                        AppRoutes.markdownViewer,
                        extra: [
                          'assets/markdown/legal/conditions_of_use.md',
                          'Conditions of Use',
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      thickness: 1.5,
                    ),
                    subProfileContent(
                      context,
                      title: "Privay Notes",
                      icon: Icons.privacy_tip,
                      onTap: () => context.push(
                        AppRoutes.markdownViewer,
                        extra: [
                          'assets/markdown/legal/privacy_notes.md',
                          'Privacy Notes',
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      thickness: 1.5,
                    ),
                    subProfileContent(
                      context,
                      title: "Help  & Feedback",
                      icon: Icons.help,
                      onTap: () {},
                    ),
                    Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      thickness: 1.5,
                    ),
                    subProfileContent(
                      context,
                      title: "About Us",
                      icon: Icons.info,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: Size(double.infinity, 56),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                    style: BorderStyle.solid,
                    strokeAlign: 0.7,
                  ),
                ),
                child: Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subProfileContent(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor = Colors.grey,
  }) {
    return Row(
      spacing: 20,
      children: [
        Icon(icon, size: 28, color: iconColor),
        Text(title, style: TextStyle(fontSize: 18)),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
