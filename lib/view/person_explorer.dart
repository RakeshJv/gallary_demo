import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallay_app/util/app_colors.dart';
import 'package:gallay_app/util/commom_component.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PersonExplorer extends StatefulWidget {

String url;

PersonExplorer({this.url});

     @override
  _PersonExplorerState createState() => _PersonExplorerState();
}

class _PersonExplorerState extends State<PersonExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {

    print(""+widget.url);
    return Scaffold(
      appBar: CommonComponent.getAppBar(COLORS.APP_THEME_COLOR, "PinkVilla"),
      body: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (WebViewController webViewController)
        {
          _controller.complete(webViewController);
        },
      ),
      //floatingActionButton: _bookmarkButton(),
    );
  }

  _bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorites.add(url);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Saved $url for later reading.')),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }
}