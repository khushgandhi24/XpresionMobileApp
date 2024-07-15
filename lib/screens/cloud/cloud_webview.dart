import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:background_downloader/background_downloader.dart';
//import 'dart:io';
//import 'package:xprapp/screens/cloud/download_helper.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
//import 'package:device_info_plus/device_info_plus.dart';
//import 'dart:isolate';
//import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class CloudWebView extends StatefulWidget {
  const CloudWebView({super.key});

  @override
  State<CloudWebView> createState() => _CloudWebViewState();
}

class _CloudWebViewState extends State<CloudWebView> {
  // final _controller = WebViewController()
  //   ..setBackgroundColor(const Color.fromRGBO(44, 59, 103, 1))
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..loadRequest(Uri.parse('https://demo.busisoft.in/MobileApplication/'));
  late InAppWebViewController _webViewController;

  // Future<bool> _checkPermission(platform) async {
  //   if (Platform.isIOS) return true;
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   if (platform == TargetPlatform.android &&
  //       androidInfo.version.sdkInt <= 28) {
  //     final status = await Permission.storage.status;
  //     // final status2 = await Permission.manageExternalStorage.status;
  //     if (status != PermissionStatus.granted) {
  //       final result = await Permission.storage.request();
  //       // final result2 = await Permission.manageExternalStorage.request();
  //       if (result == PermissionStatus.granted) {
  //         return true;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //   return false;
  // }

  // @pragma('vm:entry-point')
  // static void downloadCallback(String id, int status, int progress) {
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(24),
        //       bottomRight: Radius.circular(24)),
        // ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: const Color.fromRGBO(18, 87, 117, 1),
        toolbarHeight: 5,
        // leading: IconButton(
        //     onPressed: () {
        //       //Navigator.pushNamed(context, '/login');
        //       _webViewController.reload();
        //     },
        //     icon: Icon(
        //       Icons.arrow_circle_left_outlined,
        //       color: Theme.of(context).colorScheme.onPrimary,
        //       size: 36,
        //     )),
        // title: Image.asset(
        //   'assets/images/logos/Xpc.png',
        //   width: 140,
        //   height: 70,
        //   fit: BoxFit.contain,
        // ),
        //actions: const [Icon(Icons.replay_outlined)],
        // bottom: const PreferredSize(
        //   preferredSize: Size.fromHeight(50),
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Padding(
        //       padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
        //       child: Text('Shipment Tracking', style: TextStyle(color: Colors.white, fontSize: 16),),
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: SizedBox(
          child: PopScope(
              canPop: false,
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri(
                        "https://demo.busisoft.in/MobileApplication/CustomerRoute?path=CustomerSignIn")),
                initialSettings: InAppWebViewSettings(
                  mediaPlaybackRequiresUserGesture: false,
                  domStorageEnabled: true,
                  allowFileAccess: true,
                  loadsImagesAutomatically: true,
                  allowContentAccess: true,
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true,
                  allowsLinkPreview: true,
                  geolocationEnabled: true,
                  useWideViewPort: true,
                ),
                onGeolocationPermissionsShowPrompt: (controller, origin) async {
                  return GeolocationPermissionShowPromptResponse(
                      allow: true, origin: origin, retain: true);
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                onDownloadStartRequest:
                    (controller, DownloadStartRequest request) async {
                  //FlutterDownloader.registerCallback(downloadCallback);
                  //final platform = Theme.of(context).platform;
                  //bool value = await _checkPermission(platform);
                  //if (value) {
                  //await prepareSaveDir();
                  //{
                  // final taskId = await FlutterDownloader.enqueue(
                  //   url: request.url.toString(),
                  //   savedDir: localPath,
                  //   showNotification: true,
                  //   saveInPublicStorage:
                  //       true, // show download progress in status bar (for Android)
                  //   openFileFromNotification:
                  //       true, // click on notification to open downloaded file (for Android)
                  // );
                  var data = await http.get(request.url);
                  await Printing.layoutPdf(onLayout: (_) => data.bodyBytes);
                  //}
                  //}
                },
                //onPrintRequest: (controller, url, printJobController) {},
              )),
        ),
      ),
    );
  }
}
