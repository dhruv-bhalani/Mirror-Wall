import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:government_app/helper/shr_helpre.dart';
import 'package:government_app/model/webmodel.dart';
import 'package:government_app/screens/home/views/home_provider.dart';

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
  void initState() {
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
                color: Colors.blue.shade300, backgroundColor: Colors.white),
            onRefresh: () {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController!.reload();
              }
            },
          );
    super.initState();
  }

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
                          url: WebUri("https://www.google.com"),
                        ),
                      );
                      String url = "https://www.google.com";
                      homeproviderR.selectIndex(url);
                      homeproviderR.url = url;
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('yahoo'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.yahoo.com"),
                        ),
                      );
                      String url = "https://www.yahoo.com";
                      homeproviderR.selectIndex(url);
                      homeproviderR.url = url;
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Microsoft Bing'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.bing.com"),
                        ),
                      );
                      String url = "https://www.bing.com";
                      homeproviderR.selectIndex(url);
                      homeproviderR.url = url;
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Brave'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://brave.com"),
                        ),
                      );
                      String url = "https://brave.com";
                      homeproviderR.selectIndex(url);
                      homeproviderR.url = url;
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('DuckDuckGo'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://duckduckgo.com"),
                        ),
                      );
                      String url = "https://duckduckgo.com";
                      homeproviderR.selectIndex(url);
                      homeproviderR.url = url;
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Bing'),
                  onTap: () {
                    if (webViewController != null) {
                      webViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://www.bing.com"),
                        ),
                      );
                      String url = "https://www.bing.com";
                      homeproviderR.selectIndex(url);
                      homeproviderR.url = url;
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
          5.height,
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
          5.height,
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
                  if (progress == 100) pullToRefreshController!.endRefreshing();
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                initialUrlRequest: URLRequest(
                  // url: WebUri('${models.url}'),
                  // url: WebUri('${homeproviderW.url}'),
                  url: WebUri(
                      "${webViewController == null ? homeproviderW.url : webViewController?.getUrl()}"),
                ),
                pullToRefreshController: pullToRefreshController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
