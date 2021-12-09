import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() => runApp(KmcuApp());

class KmcuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KMCUHomePage(),
    );
  }
}

class KMCUHomePage extends StatefulWidget {
  KMCUHomePage({Key? key}) : super(key: key);

  @override
  _KMCUHomePageState createState() => _KMCUHomePageState();
}

class _KMCUHomePageState extends State<KMCUHomePage> {
  late WebViewController _controller;

  final Completer<WebViewController> _completerController = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context){
    return Container(
        child: SafeArea(
            child:WillPopScope(
              onWillPop: () => _goBack(context),
              child: WebView(
                onWebViewCreated: (WebViewController webViewController) {
                  _completerController.future.then((value) => _controller = value);
                  _completerController.complete(webViewController);
                },
                initialUrl: "https://www.kmcu.ac.kr/kr/index.php?ref=1",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            )
        )
    );
  }

  Future<bool> _goBack(BuildContext context) async{
    if(await _controller.canGoBack()){
      _controller.goBack();
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

}