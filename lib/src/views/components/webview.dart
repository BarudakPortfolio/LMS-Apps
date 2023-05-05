import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen(this.url, {super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  String title = '';
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    getData();
    super.initState();
  }

  void getData() async {
    final judul = (await controller.getTitle())!;
    print('ini $judul');
    setState(() {
      title = judul;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 0, 0, 0),
                  items: [
                    PopupMenuItem(
                      onTap: () {
                        print(widget.url);
                      },
                      child: Text('Buka di Browser'),
                    ),
                    PopupMenuItem(child: Text("Salin Tautan"))
                  ],
                );
              },
              icon: Icon(Icons.more_vert),
            )
          ],
          title: ListTile(
            title: Text(
              'LMS Webview',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.url,
              style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
            ),
          )),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
