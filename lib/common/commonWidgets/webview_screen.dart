import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import 'package:msp_educare_demo/dialog/exit_webview_dialog.dart';
//
// class WebViewScreen extends StatefulWidget {
//   // final String title;
//   // final String link;
//   //
//   // const WebViewScreen({Key? key, required this.title, required this.link})
//   //     : super(key: key);
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   InAppWebViewController? _webViewController;
//   late String link;
//
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//     // if (Platform.isAndroid) WebView.platform = AndroidWebView();
//
//     link = Get.arguments;
//     print('URL :$link');
//   }
//
//   @override
//   void dispose() {
//     _webViewController?.stopLoading();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         showExitWebViewDialog();
//         return Future.value(false);
//       },
//       child: Scaffold(
//         // appBar: AppBar(
//         //   backgroundColor: ColorUtils.purple,
//         //   // title: Text(widget.title),
//         //   leading: Icon(Icons.arrow_back),
//         //   centerTitle: true,
//         // ),
//         body: SafeArea(
//           child: InAppWebView(
//               initialUrlRequest: URLRequest(url: Uri.parse(link.trim())),
//               initialOptions: InAppWebViewGroupOptions(
//                 crossPlatform: InAppWebViewOptions(
//                   mediaPlaybackRequiresUserGesture: false,
//                   javaScriptEnabled: true,
//                 ),
//               ),
//               onWebViewCreated: (InAppWebViewController controller) {
//                 _webViewController = controller;
//               },
//               androidOnPermissionRequest: (InAppWebViewController controller,
//                   String origin, List<String> resources) async {
//                 return PermissionRequestResponse(
//                     resources: resources,
//                     action: PermissionRequestResponseAction.GRANT);
//               }),
//         ),
//       ),
//     );
//   }
// }
