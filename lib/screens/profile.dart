import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Profile"),
      body: SafeArea(child: Center(child: Text("Profile"))),
    );
  }
}
