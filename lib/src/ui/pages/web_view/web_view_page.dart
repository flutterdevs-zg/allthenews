import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage(this.url) : assert(url != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NyTimesAppBar(
        hasBackButton: true,
        backButtonAction: () => Navigator.pop(context),
      ),
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
