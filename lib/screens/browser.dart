import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';

class BrowserPage extends StatelessWidget {
  const BrowserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Browser"),
      body: SafeArea(child: Center(child: Text("Browser"))),
    );
  }
}
