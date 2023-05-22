import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
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
                  position: const RelativeRect.fromLTRB(100, 0, 0, 0),
                  items: [
                    PopupMenuItem(
                      onTap: () async {
                        await launchUrl(Uri.parse(widget.url),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text('Buka di Browser'),
                    ),
                    PopupMenuItem(
                        onTap: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: widget.url))
                              .then((value) {
                            // if (mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Tautan Berhasil di salin"),
                              ),
                            );
                          });
                        },
                        child: const Text("Salin Tautan"))
                  ],
                );
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
          title: ListTile(
            title: const Text(
              'LMS Webview',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.url,
              style: const TextStyle(
                  fontSize: 10, overflow: TextOverflow.ellipsis),
            ),
          )),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
