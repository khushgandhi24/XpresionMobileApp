import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';
//import 'package:gradient_borders/gradient_borders.dart';


class AWBWebView extends StatefulWidget {
  const AWBWebView({super.key});

  @override
  State<AWBWebView> createState() => _AWBWebViewState();
}

class _AWBWebViewState extends State<AWBWebView> {

  var title = '';
  //final String url = 'https://demo.busisoft.in/MobileApplication/CustomerRoute?path=customerawbentry';
  final _controller = WebViewController()
    ..setBackgroundColor(const Color.fromRGBO(44, 59, 103, 1))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://demo.busisoft.in/MobileApplication/DeliveryRoute?path=TRACKING&LoginToken=2tkjhg0d3vrvdtaprul50mi1&UserId=bhargav'));

  final scaffoldKey = GlobalKey<ScaffoldState>();

  checkPageLoaded () {  
    Future.delayed(const Duration(seconds: 5), () async {
      var temp = await _controller.currentUrl();
      debugPrint(temp);
    });
    
    
  }

  @override
  void initState() {
    checkPageLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: scaffoldKey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),),
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
          )
        ),
        title: GestureDetector(
          onTap: () async {
            var temp = await _controller.getTitle();
            setState(() {
              title = temp ?? '';
            });
            debugPrint(temp);
          },
          child: Image.asset('assets/images/logos/Xpr.png',
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
      drawer: const XprDrawer(mode: 'cust',),
      bottomNavigationBar: const NavBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            // border: const GradientBoxBorder(
            //   width: 4,
            //   gradient: LinearGradient(
            //     colors: [Color.fromRGBO(44, 59, 103, 1), Colors.white],
            //     stops: [0, 1],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //   ),
            // ),
            //border: (color: const Color.fromRGBO(44, 59, 103, 1), width: 8)
          ),
          child: WebViewWidget(controller: _controller,) 
          /*(title.isNotEmpty) ? WebViewWidget(
            controller: _controller,
          )
          :
          Center(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1, 
              width: MediaQuery.sizeOf(context).width * 0.2, 
              child: CircularProgressIndicator(strokeWidth: 5,
              value: null, 
              color: Theme.of(context).colorScheme.inverseSurface,
              )
            ),
          )*/
        ),
      ),
    );
  }
}