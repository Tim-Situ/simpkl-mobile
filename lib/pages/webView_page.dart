import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({super.key, required this.title, required this.url});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewController
      _webViewController; // Controller yang akan diinisialisasi

  @override
  void initState() {
    super.initState();
    // Pastikan untuk menginisialisasi WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // print("Page started: $url");
          },
          onPageFinished: (String url) {
            // print("Page finished: $url");
          },
        ),
      );
    _webViewController.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD3D1D8).withOpacity(0.3),
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent, // Menghapus warna latar belakang
        elevation: 0,
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
