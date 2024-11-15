import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:government_app/model/webmodel.dart';
import 'package:government_app/screens/home/views/home_provider.dart';
import 'package:government_app/screens/webpage/web_provider.dart';
import 'package:government_app/utils/extension.dart';
import 'package:provider/provider.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  InAppWebViewController? webViewController;
  late Homeprovider homeproviderW;
  late Homeprovider homeproviderR;
  PullToRefreshController? pullToRefreshController;
  @override
  Widget build(BuildContext context) {
    homeproviderW = context.watch<Homeprovider>();
    homeproviderR = context.read<Homeprovider>();

    final WebModels models =
        ModalRoute.of(context)!.settings.arguments as WebModels;

    return Scaffold(
      appBar: AppBar(
        title: Text("${models.title}"),
        actions: [
          IconButton(
            onPressed: () async {
              if (webViewController != null &&
                  await webViewController!.canGoBack()) {
                webViewController!.goBack();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          IconButton(
            onPressed: () async {
              if (webViewController != null) {
                webViewController!.reload();
              }
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              if (webViewController != null &&
                  await webViewController!.canGoForward()) {
                webViewController!.goForward();
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("Google"),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                          urlRequest: URLRequest(
                              url: WebUri("https://www.google.com")));
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('yahoo'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                          urlRequest:
                              URLRequest(url: WebUri("https://www.yahoo.com")));
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Microsoft Bing'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                          urlRequest:
                              URLRequest(url: WebUri("https://www.bing.com")));
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Brave'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                          urlRequest:
                              URLRequest(url: WebUri("https://brave.com")));
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('DuckDuckGo'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                          urlRequest: URLRequest(
                              url: WebUri("https://duckduckgo.com")));
                    }
                  },
                ),
                PopupMenuItem(
                  child: Text('Bing'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                          urlRequest:
                              URLRequest(url: WebUri("https://www.bing.com")));
                    }
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: homeproviderW.progress,
          ),
          10.height,
          TextField(
            decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              if (webViewController != null) {
                webViewController!.loadUrl(
                  urlRequest: URLRequest(
                    url: WebUri("https://www.google.com/search?q=$value"),
                  ),
                );
              }
            },
          ),
          50.height,
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (webViewController != null) {
                  await webViewController!.reload();
                }
              },
              child: InAppWebView(
                onProgressChanged: (controller, progress) {
                  homeproviderR.changeProgress(progress / 100);
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                initialUrlRequest: URLRequest(
                  url: WebUri('${models.url}'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
