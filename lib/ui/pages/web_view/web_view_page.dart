import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({Key key, this.url})
      : assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
          );
        },
      ),
    );
  }
}
