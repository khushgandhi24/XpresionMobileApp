import 'package:flutter/material.dart';
import 'package:xprapp/screens/track/shipment_details.dart';
import 'package:xprapp/screens/track/shipment_tile.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';

class Tracking extends StatefulWidget {
  const Tracking({super.key});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: scaffoldKey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 90,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 36,
            )),
        title: Image.asset(
          'assets/images/logos/Xpr.png',
          width: 140,
          height: 70,
          fit: BoxFit.cover,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                'Shipment Tracking',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
      drawer: const XprDrawer(
        mode: 'cust',
      ),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.secondaryContainer
                ],
                stops: const [
                  0,
                  1
                ],
                begin: const AlignmentDirectional(0, -1),
                end: const AlignmentDirectional(0, 1)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                const ShipmentDetails(
                  awb: 'awb',
                  date: 'date',
                  status: 'status',
                  watch: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, count) {
                        return const ShipTile(
                            date: 'date', status: 'status', area: 'area');
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
