import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Discover"),
      body: SafeArea(child: Center(child: Text("Discover"))),
    );
  }
}
