import 'package:flutter/material.dart';
import 'package:github_stars/widgets/github_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();

    WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GithubAppBar(),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
