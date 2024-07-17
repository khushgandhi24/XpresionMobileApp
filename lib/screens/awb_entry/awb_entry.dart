import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:xprapp/shared/xpr_drawer.dart';

class AWBEntry extends StatefulWidget {
  const AWBEntry({super.key});

  @override
  State<AWBEntry> createState() => _AWBEntryState();
}

class _AWBEntryState extends State<AWBEntry> {
  late InAppWebViewController _webViewController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 65,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 36,
            )),
        title: GestureDetector(
          onTap: () async {},
          child: Image.asset(
            'assets/images/logos/Xpr.png',
            width: 140,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
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
      drawer: const XprDrawer(),
      body: SafeArea(
        child: SizedBox(
          child: PopScope(
              canPop: true,
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
                  var data = await http.get(request.url);
                  await Printing.layoutPdf(onLayout: (_) => data.bodyBytes);
                },
              )),
        ),
      ),
    );
  }
}
