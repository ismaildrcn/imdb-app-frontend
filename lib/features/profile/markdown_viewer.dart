import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class MarkdownViewer extends StatefulWidget {
  final String markdownAssetPath;
  final String title;
  const MarkdownViewer({
    super.key,
    required this.markdownAssetPath,
    required this.title,
  });

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
      body: SafeArea(
        child: _markdownRaw.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 32),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Markdown(
                      data: _markdownRaw,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      styleSheet: MarkdownStyleSheet(
                        h3Padding: EdgeInsets.only(top: 18, bottom: 8),
                        pPadding: EdgeInsets.only(bottom: 12),
                        listBulletPadding: EdgeInsets.only(right: 8),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
