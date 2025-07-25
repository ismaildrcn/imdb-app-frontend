import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:imdb_app/app/router.dart';

class MarkdownViewer extends StatefulWidget {
  final String markdownAssetPath;
  const MarkdownViewer({super.key, required this.markdownAssetPath});

  @override
  State<MarkdownViewer> createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  String _markdownRaw = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  Future<void> _loadMarkdown() async {
    final response = await rootBundle.loadString(widget.markdownAssetPath);
    setState(() {
      _markdownRaw = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Privacy Notice"),
      body: SafeArea(
        child: _markdownRaw.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Markdown(
                data: _markdownRaw,
                styleSheet: MarkdownStyleSheet(
                  h1Padding: EdgeInsets.only(top: 24, bottom: 12),
                  h2Padding: EdgeInsets.only(top: 20, bottom: 10),
                  pPadding: EdgeInsets.only(bottom: 12),
                  listBulletPadding: EdgeInsets.only(right: 8),
                ),
              ),
      ),
    );
  }
}
