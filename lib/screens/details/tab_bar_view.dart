import 'package:flutter/material.dart';
import 'package:xprapp/screens/auth/log_in.dart';
import 'package:xprapp/screens/home/map_tile.dart';
import 'package:xprapp/shared/awb_search.dart';
import 'package:xprapp/shared/pickup_dialog.dart';
import 'package:xprapp/theme.dart';
import 'package:dio/dio.dart';
import 'package:xprapp/screens/home/home_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:xprapp/screens/details/delivery_model.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

class PickupTBView extends StatefulWidget {
  const PickupTBView(
      {super.key, this.history = false, this.neww = false, required this.show});

  final bool history;
  final bool neww;
  final bool show;

  @override
  State<PickupTBView> createState() => _PickupTBViewState();
}

class _PickupTBViewState extends State<PickupTBView> {
  final storage = const FlutterSecureStorage();
  List<PickupId> ptiles = [];
  bool isLoading = false;

  ItemScrollController pickupController = ItemScrollController();

  Future<List<double>> addrToLatLng(String addr) async {
    List<Location> locations = await locationFromAddress(addr);
    return [locations.last.latitude, locations.last.longitude];
  }

  Future<void> fetchPickupList() async {
    setState(() {
      isLoading = true;
    });

    if (await storage.read(key: 'access_token') != '') {
      try {
        final res = await dio.get('/pickups/list',
            options: Options(headers: {
              'Authorization':
                  "Bearer ${await storage.read(key: 'access_token')}"
            }));
        PickupAll details = PickupAll.fromJson(res.data);
        if (details.data.isNotEmpty) {
          var ids = [];
          var addrs = [];
          List<PickupId> pickups = [];
          for (int i = 0; i < details.data.length; i++) {
            ids.add(details.data[i].id);
          }
          await Future.wait(ids.map((id) async {
            final resp = await dio.get('/pickups/$id',
                options: Options(headers: {
                  'Authorization':
                      "Bearer ${await storage.read(key: 'access_token')}"
                }));
            PickupId pdetail = PickupId.fromJson(resp.data);
            pdetail.data.first.latlng = await addrToLatLng(
                "${pdetail.data.first.details.first.location?.address1} ${pdetail.data.first.details.first.location?.address2}");
            //debugPrint(pdetail.data.first.latlng.toString());
            pickups.add(pdetail);
            addrs.add(
                "${pdetail.data.first.details.first.location?.address1} ${pdetail.data.first.details.first.location?.address2}");
          }));
          List<List<double>> latlng = [];
          await Future.wait(addrs.map((addr) async {
            latlng.add(await addrToLatLng(addr));
          }));
          setState(() {
            ptiles = pickups;
            isLoading = false;
          });
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          try {
            final rsp = await dio.post('/refreshtoken',
                data: {
                  "refreshToken": await storage.read(key: "refresh_token")
                },
                options: Options(headers: {
                  'Authorization':
                      "Bearer ${await storage.read(key: 'access_token')}"
                }));
            Token token = Token.fromJson(rsp.data);
            debugPrint('Call completes');

            if (token.success) {
              await storage.write(
                  key: 'access_token',
                  value: token.accesstoken.replaceAll('Bearer', '').trim());
              await storage.write(
                  key: 'refresh_token', value: token.refreshtoken);
            }
            fetchPickupList();
          } on DioException catch (e) {
            if (e.response?.statusCode == 401) {
              setState(() {
                isLoading = false;
              });
              await storage.write(key: 'keepLoggedIn', value: 'false');
              if (!mounted) return;
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => const LogIn()));
            }
          }
        }
      }
    }
  }

  Future<void> _showDialog(bool isActive) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return PickupDialog(
            isActive: isActive,
          );
        });
  }

  @override
  void initState() {
    fetchPickupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lightColorScheme.surface, lightColorScheme.primaryContainer],
          stops: const [0, 1],
          begin: const AlignmentDirectional(0, -1),
          end: const AlignmentDirectional(0, 1),
        ),
      ),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          const AWBSearch(
            page: 'pickup/delivery',
          ),
          const SizedBox(
            height: 16,
          ),
          (isLoading)
              ? Center(
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        value: null,
                        color: lightColorScheme.inverseSurface,
                      )),
                )
              : Expanded(
                  child: ScrollablePositionedList.builder(
                      itemCount: ptiles.length,
                      itemScrollController: pickupController,
                      itemBuilder: (context, int index) {
                        return MapTile(
                          isHistory: widget.history,
                          isNew: widget.neww,
                          onTap: () => _showDialog(widget.show),
                          person: ptiles[index]
                                  .data
                                  .first
                                  .details
                                  .first
                                  .info
                                  ?.name ??
                              "N/A",
                          address:
                              "${ptiles[index].data.first.details.first.location?.address1} ${ptiles[index].data.first.details.first.location?.address2}",
                          area: ptiles[index]
                                  .data
                                  .first
                                  .details
                                  .first
                                  .location
                                  ?.area ??
                              "N/A",
                          mobileno: ptiles[index]
                                  .data
                                  .first
                                  .details
                                  .first
                                  .location
                                  ?.mobileno
                                  .toString() ??
                              "N/A",
                          tnum: ptiles[index].data.first.pickupNo,
                          instructions:
                              ptiles[index].data.first.specialinstructions ??
                                  "N/A",
                          latlng: ptiles[index].data.first.latlng ??
                              const [1.0, 2.0],
                          datetime:
                              "${DateTime.parse(ptiles[index].data.first.pickupdate).day}/${DateTime.parse(ptiles[index].data.first.pickupdate).month}/${DateTime.parse(ptiles[index].data.first.pickupdate).year}, ${DateTime.parse(ptiles[index].data.first.pickupdate).hour}:${DateTime.parse(ptiles[index].data.first.pickupdate).minute}",
                        );
                      }),
                ),
        ],
      ),
    );
  }
}

class DeliveryTBView extends StatefulWidget {
  const DeliveryTBView({super.key});

  @override
  State<DeliveryTBView> createState() => _DeliveryTBViewState();
}

class _DeliveryTBViewState extends State<DeliveryTBView> {
  bool isLoading = false;
  final storage = const FlutterSecureStorage();
  int index = 0;
  List<DDatum> dtiles = [];

  Future<List<double>> addrToLatLng(String addr) async {
    try {
      List<Location> locations = await locationFromAddress(addr);
      debugPrint("Got it!");
      return [locations.last.latitude, locations.last.longitude];
    } catch (e) {
      debugPrint("didn't get it!");
      return [19.0, 27.0];
    }
  }

  Future<void> fetchDeliveryList() async {
    // if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    if (await storage.read(key: 'access_token') != '') {
      debugPrint("Delivery Call Start");
      try {
        final res = await dio.get('/drs/awb/details',
            options: Options(headers: {
              'Authorization':
                  'Bearer ${await storage.read(key: 'access_token')}'
            }));
        debugPrint("Delivery Call Finish");
        DeliveryAll details = DeliveryAll.fromJson(res.data);
        if (details.data.isNotEmpty) {
          for (int x = 0; x < details.data.length; x++) {
            debugPrint("Addr to LatLng");
            details.data[x].latlng = await addrToLatLng(
                "${details.data[x].consigneedetails.address1} ${details.data[x].consigneedetails.address2}");
          }
          for (int i = 0; i < details.data.length; i++) {
            debugPrint("Adding data to dtiles");
            dtiles.add(details.data[i]);
          }
          debugPrint("Returning!");
          setState(() {
            isLoading = false;
          });
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          debugPrint(await storage.read(key: 'access_token'));
          debugPrint(await storage.read(key: 'refresh_token'));
          debugPrint('Refresh Token Call Starts');
          try {
            final rsp = await dio.post('/refreshtoken',
                data: {
                  "refreshToken": await storage.read(key: "refresh_token")
                },
                options: Options(headers: {
                  'Authorization':
                      "Bearer ${await storage.read(key: 'access_token')}"
                }));
            Token token = Token.fromJson(rsp.data);
            debugPrint('Refresh Token Call completes');

            if (token.success) {
              await storage.write(
                  key: 'access_token',
                  value: token.accesstoken.replaceAll('Bearer', '').trim());
              await storage.write(
                  key: 'refresh_token', value: token.refreshtoken);
              //debugPrint(await storage.read(key: 'access_token'));
            }
            fetchDeliveryList();
          } on DioException catch (e) {
            if (e.response?.statusCode == 401) {
              setState(() {
                isLoading = false;
              });
              debugPrint('LogOut');
              await storage.write(key: 'keepLoggedIn', value: 'false');
              if (!mounted) return;
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Session Timed Out!',
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        child: const Text(
                          'Please log in again!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text('Retry Login'))
                      ],
                      actionsAlignment: MainAxisAlignment.center,
                    );
                  });
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDeliveryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lightColorScheme.surface, lightColorScheme.primaryContainer],
          stops: const [0, 1],
          begin: const AlignmentDirectional(0, -1),
          end: const AlignmentDirectional(0, 1),
        ),
      ),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: (isLoading)
          ? Center(
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    value: null,
                    color: lightColorScheme.inverseSurface,
                  )),
            )
          : Column(
              children: [
                const AWBSearch(
                  page: 'pickup/delivery',
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: dtiles.length,
                      itemBuilder: (context, index) {
                        return MapTile(
                          state: false,
                          person: dtiles[index].consigneename,
                          tnum: dtiles[index].awbnumber,
                          mobileno: dtiles[index]
                              .consigneedetails
                              .mobileno
                              .toString(),
                          address: dtiles[index].consigneedetails.address1 +
                              dtiles[index].consigneedetails.address2,
                          datetime:
                              "${DateTime.parse(dtiles[index].bookingdate).day}/${DateTime.parse(dtiles[index].bookingdate).month}/${DateTime.parse(dtiles[index].bookingdate).year}, ${DateTime.parse(dtiles[index].bookingdate).hour}:${DateTime.parse(dtiles[index].bookingdate).minute}",
                          onTap: () {
                            Navigator.pushNamed(context, '/pod');
                          },
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
