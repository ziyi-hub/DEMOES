import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Conditions extends StatefulWidget {
  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  final title = "Conditions d'utilisation";
  late WebViewController controller;

  void loadLocalHtml() async {
    final html =
        await rootBundle.loadString('samples/BrowsingPois/html/condition.html');
    final url = Uri.dataFromString(
      html,
      mimeType: "text/html",
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;

            loadLocalHtml();
          },
        ),
      );
}
