import 'package:flutter/material.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:fooderlich/models/models.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  static MaterialPage page() => MaterialPage(
        name: FooderlichPages.raywenderlich,
        key: ValueKey(
          FooderlichPages.raywenderlich,
        ),
        child: const WebViewScreen(),
      );

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.raywenderlich.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('raywenderlich.com'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
