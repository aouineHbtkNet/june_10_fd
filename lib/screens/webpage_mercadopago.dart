import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageMercadoPago extends StatefulWidget {
  static const String id = '/WebPageMercadoPago';
  var url;
  WebPageMercadoPago({required this.url});


  @override
  State<WebPageMercadoPago> createState() => _WebPageMercadoPagoState();

}

class _WebPageMercadoPagoState extends State<WebPageMercadoPago> {
  WebViewController? _controller;
  final _keyWebView = UniqueKey();
  double progress = 0;
  int count =0;

  @override
  Widget build(BuildContext context) {

   // _controller!.loadUrl(url);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                if (await _controller!.canGoBack()) {
                  _controller!.goBack();
                }
              },
              icon: Icon(Icons.arrow_back_ios))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
     _controller!.reload();

      },child: Icon(Icons.refresh),),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.white,

          ),

          Expanded(
            child: WebView(
              key: _keyWebView,
              initialUrl: widget.url,

              onWebViewCreated: (WebViewController webViewController) {
           setState(() {_controller = webViewController;});},

              javascriptMode: JavascriptMode.unrestricted,

              onPageStarted: (String url) {
                print('Page started loading: $url');

              },
              onProgress: (progress) {
                setState(() {
                  this.progress = progress / 100;

                });
              },
              gestureNavigationEnabled: true,

              onPageFinished: (String url) {
                print('Page finished loading ${count++} : $url');

                setState(() {
                  _controller!.currentUrl();
                });

                // if (url==_controller!.currentUrl()){
                //
                //   _controller!.reload();
                // }
                readResponse();

              },


            ),
          ),
        ],
      ),
    );
  }

  String valuevar = '';

  void setIsLoading() async {
    setState(() {
      print('isloading.......................');
    });
  }


  void readResponse() async {
    setState(() {

       // _controller!.runJavascriptReturningResult("document.documentElement.innerText; ").
       _controller!.runJavascriptReturningResult("window.document.body.innerText;").
       then((value) async {
         String newurl = _controller!.currentUrl().toString();



         print ('value innerHtml : ${value}');
        // await  _controller!.currentUrl();


         // if(value.contains("name=\"paymentId\"")){
       // print('from webview function readResponse $value');
      });
    });

  }
}
