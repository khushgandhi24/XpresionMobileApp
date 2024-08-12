import 'package:flutter/material.dart';
import 'package:xprapp/screens/track/shipment_details.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';

class HomeTile extends StatelessWidget {
  const HomeTile(
      {super.key, required this.text, required this.icon, required this.route});

  final String text;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ButtonStyle(
        //padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 2),
            borderRadius: BorderRadius.circular(72))),
        backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primaryContainer),
        foregroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.onPrimaryContainer),
        minimumSize: WidgetStatePropertyAll(
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.1565)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(text),
          Icon(
            icon,
            size: 48,
          ),
        ],
      ),
    );
    // return GestureDetector(
    //   onTap: () => Navigator.pushNamed(context, route),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       boxShadow: [
    //         BoxShadow(
    //           color: Theme.of(context).colorScheme.onSecondaryContainer,
    //           spreadRadius: 0.5,
    //           blurRadius: 0.1,
    //           offset: const Offset(0, 0),
    //         ),
    //       ],
    //       color: Theme.of(context).colorScheme.secondaryContainer,
    //       borderRadius: BorderRadius.circular(24),
    //       border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 2)
    //     ),
    //     height: MediaQuery.sizeOf(context).height * 0.1565,
    //     child:  Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Text(text),
    //         Icon(icon, size: 48,),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool showTracking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: const XprDrawer(
          mode: 'cust',
        ),
        appBar: AppBar(
          title: RichText(
            text: const TextSpan(
              text: 'Welcome,\n',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                    text: 'Username',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            textAlign: TextAlign.center,
          ), // const Text("Welcome\nCustomer Name", textAlign: TextAlign.center,),
          titleTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
                //debugPrint(ModalRoute.of(context)!.settings.name);
              },
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 36,
              )),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/notifications'),
              icon: const Icon(
                Icons.notifications,
                size: 32,
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 4))
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: 100,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    (hasFocus) ? showTracking = true : showTracking = false;
                  });
                },
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search_rounded),
                    hintText: 'Track your order',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 2)),
                  ),
                  onSubmitted: (value) {
                    Navigator.pushNamed(context, '/custTrack');
                  },
                ),
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24)),
          ),
        ),
        body: SafeArea(
            child: Container(
          color: Theme.of(context).colorScheme.surface,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.secondaryContainer],
          //     stops: const[0,1],
          //     begin: const AlignmentDirectional(0, -1),
          //     end: const AlignmentDirectional(0, 1)
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
                child: (!showTracking)
                    ? const Column(children: [
                        SizedBox(
                          height: 36,
                        ),
                        HomeTile(
                          text: 'Send',
                          icon: Icons.send_rounded,
                          route: '/getQuote',
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        HomeTile(
                          text: 'Get Quote',
                          icon: Icons.request_quote_rounded,
                          route: '/getQuote',
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        HomeTile(
                          text: 'Watchlist',
                          icon: Icons.watch_later_rounded,
                          route: '/watchlist',
                        ),
                        SizedBox(
                          height: 36,
                        ),
                      ])
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          (showTracking)
                              ? const ShipmentDetails(
                                  awb: '24012001',
                                  date: '9/5/24',
                                  status: 'Sleeping',
                                  watch: true,
                                )
                              : const SizedBox.expand(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
          ),
        )),
        bottomNavigationBar: const NavBar());
  }
}
