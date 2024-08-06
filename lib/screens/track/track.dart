import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/screens/track/shipment_details.dart';
import 'package:xprapp/screens/track/shipment_tile.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/shared/awb_search.dart';
import 'package:xprapp/shared/xpr_drawer.dart';

class Track extends StatefulWidget {
  const Track({super.key});

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // final int count = 6;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
        builder: (context, value, child) => Scaffold(
              key: scaffoldKey,
              // App Bar
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 76,
                leading: IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Icon(
                        Icons.menu_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 36,
                      ),
                    )),
                title: Image.asset(
                  'assets/images/logos/Xpr_Color.png',
                  width: 140,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                centerTitle: true,
              ),
              // Drawer
              drawer: const XprDrawer(),
              // Body
              body: SafeArea(
                // Main Container
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.surface,
                                Theme.of(context).colorScheme.primaryContainer,
                              ],
                              stops: const [
                                0,
                                1
                              ],
                              begin: const AlignmentDirectional(0, -1),
                              end: const AlignmentDirectional(0, 1)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Text(
                                'Track Shipment',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const AWBSearch(
                              page: 'track',
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            (!value.isTracking)
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        ShipmentDetails(
                                          awb: value.query,
                                          date: value.shipment.data.first
                                              .transactiondate,
                                          status: value.shipment.data.first
                                              .transactionstatus,
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1, 0),
                                          child: Text(
                                            'Shipment History',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        (value.shipment.data.isNotEmpty)
                                            ? Expanded(
                                                child: ListView.builder(
                                                  itemCount: value
                                                      .shipment.data.length,
                                                  itemBuilder:
                                                      (context, count) {
                                                    return ShipTile(
                                                      date: value
                                                          .shipment
                                                          .data[count]
                                                          .transactiondate,
                                                      status: value
                                                          .shipment
                                                          .data[count]
                                                          .transactionstatus,
                                                      area: value.shipment
                                                          .data[count].area,
                                                    );
                                                  },
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 24,
                                              ),
                                      ],
                                    ),
                                  )
                                : (!value.isLoading)
                                    ? Text(
                                        (value.valid.isNotEmpty)
                                            ? (value.valid)
                                            : "",
                                        textAlign: TextAlign.center,
                                      )
                                    : Center(
                                        child: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.05,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 4,
                                              value: null,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inverseSurface,
                                            )),
                                      ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
