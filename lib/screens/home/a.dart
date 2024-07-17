import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/screens/home/map_tile.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/shared/pickup_dialog.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/shared/map_states.dart';
import 'package:xprapp/theme.dart';
import 'package:dio/dio.dart';
import 'package:xprapp/screens/home/home_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

// class DioInterceptor extends Interceptor {
//   Dio diocep = Dio(BaseOptions(baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net'));
//   final storage = FlutterSecureStorage();

//   String? accTok;
//   String? refTok;

//   void getToken() async {
//     final val = await storage.read(key: 'access_token');
//     final rval = await storage.read(key: 'refresh_token');
//     accTok = val;
//     refTok = rval;
//   }

//   Future<void> refreshToken(String accToken, String refToken) async {
//     try {
//       final res = await dio.post('/refreshtoken', data: {"refreshToken": refToken},options: Options(headers: {'Authorization': "Bearer $accToken"},));
//       if (res.statusCode == 200) {
//         Token tokenVal = Token.fromJson(res.data);
//         await storage.write(key: 'access_token', value: tokenVal.accesstoken);
//         await storage.write(key: 'refresh_token', value: tokenVal.refreshtoken);
//       }
//     } on DioException catch (e) {
//       debugPrint(e.message);
//     }
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     getToken();
//     if(accTok != '') {
//       options.headers.addAll({
//         "Authorization": "Bearer $accTok",
//       });
//     }
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     getToken();
//     if (err.response?.statusCode ==  401) {
//       await refreshToken(accTok!, refTok!);
//     }
//   }

// }

class XHome extends StatefulWidget {
  const XHome({super.key});

  @override
  State<XHome> createState() => _HomeState();
}

class _HomeState extends State<XHome> with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final mapController = MapController();

  bool isLoading = false;

  late final AnimationController _animController;
  late final Animation<double> _rotationAnim;
  final double maxScrollHeight = 0.98;
  final double minScrollHeight = 0.12;
  final dsController = DraggableScrollableController();

  int _value = 0;

  Map<dynamic, List<double>> markerCoords = {};
  List<PickupId> ptiles = [];
  ItemScrollController listController = ItemScrollController();

  Future<List<double>> addrToLatLng(String addr) async {
    debugPrint(addr);
    var output = [0.0, 0.0];
    try {
      List<Location> locations = await locationFromAddress(addr);
      if (locations.isNotEmpty) {
        debugPrint(locations.last.timestamp.toString());
        output = [locations.last.latitude, locations.last.longitude];
      }
      return output;
    } on NoResultFoundException catch (e) {
      debugPrint(e.toString());
      return output;
    }
  }

  Future<void> fetchPickupList() async {
    setState(() {
      isLoading = true;
    });
    if (await storage.read(key: 'access_token') != '') {
      try {
        debugPrint('Pickup All Call Start');
        final res = await dio.get('/pickups/list',
            options: Options(headers: {
              'Authorization':
                  "Bearer ${await storage.read(key: 'access_token')}"
            }));
        PickupAll details = PickupAll.fromJson(res.data);
        debugPrint('Pickup All Call Finish');
        //debugPrint(details.data.length.toString());
        if (details.data.isNotEmpty) {
          //debugPrint(details.data.first.id.toString());
          var ids = [];
          var addrs = [];
          List<PickupId> pickups = [];
          for (int i = 0; i < details.data.length; i++) {
            ids.add(details.data[i].id);
          }
          debugPrint(ids.toString());
          debugPrint("Pickup ID Call Start");
          await Future.wait(ids.map((id) async {
            debugPrint("$id Call Start");
            var count = 1;
            final resp = await dio.get('/pickups/$id',
                options: Options(headers: {
                  'Authorization':
                      "Bearer ${await storage.read(key: 'access_token')}"
                }));
            debugPrint("$id Call Finish");
            PickupId pdetail = PickupId.fromJson(resp.data);
            debugPrint("$count $id call");
            debugPrint(
                "Address 1: ${pdetail.data.first.details.first.location?.address1}");
            debugPrint(
                "Address 2: ${pdetail.data.first.details.first.location?.address2}");
            pdetail.data.first.latlng = await addrToLatLng(
                "${pdetail.data.first.details.first.location?.address1} ${pdetail.data.first.details.first.location?.address2}");
            count++;
            debugPrint(pdetail.data.first.latlng.toString());
            pickups.add(pdetail);
            addrs.add(
                "${pdetail.data.first.details.first.location?.address1} ${pdetail.data.first.details.first.location?.address2}");
          }));
          debugPrint(ids.toString());
          debugPrint(addrs.toString());
          debugPrint(
              DateTime.parse(pickups.first.data.first.pickupdate).toString());
          List<List<double>> latlng = [];
          await Future.wait(addrs.map((addr) async {
            latlng.add(await addrToLatLng(addr));
            //List<Location> locations = await locationFromAddress(addr);
            //latlng.add([locations.last.latitude, locations.last.longitude]);
          }));
          // final tlist = List.generate(ids.length, (index) => [ids[index], latlng[index]]);
          // debugPrint(tlist.toString());
          //debugPrint(latlng.toString());
          //debugPrint(pickups.first.data.first.latlng.toString());
          final mapper = Map.fromIterables(ids, latlng);
          setState(() {
            isLoading = false;
            markerCoords = mapper;
            ptiles = pickups;
          });

          // final pID = details.data.first.id.toString();
          // final rest = await dio.get('/pickups/$pID', options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
          //debugPrint(rest.data.toString());
          //PickupId pdetails = PickupId.fromJson(rest.data);
          //debugPrint(pdetails.data.first.contactperson);
        }
      } on DioException catch (e) {
        //debugPrint(e.message);
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
            fetchPickupList();
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

  // bool isMin = true;

  void selectChip(bool selected, int index) {
    setState(() {
      _value = selected ? index : index + 1;
    });
  }

  void animateOnTap(double height) {
    dsController.animateTo(
      height,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void toggle() {
    if (dsController.size == maxScrollHeight) {
      animateOnTap(minScrollHeight);
    } else {
      animateOnTap(maxScrollHeight);
    }
  }

  Future<void> _showDialog() {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return const PickupDialog();
        });
  }

  // Future<void> backBlock() async {
  //   return showDialog<void>(
  //     barrierDismissible: false,
  //     context: context, builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Leaving App'),
  //         content: const StyledText('Are you sure you want to exit the app?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               SystemNavigator.pop();
  //             },
  //             child: const StyledText('Yes'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('No'),
  //           ),
  //         ],
  //         actionsAlignment: MainAxisAlignment.center,
  //       );
  //     }
  //   );
  // }

  @override
  void initState() {
    fetchPickupList();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnim =
        Tween<double>(begin: 0.0, end: 0.5).animate(_animController);
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    dsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
        builder: (context, value, child) => Scaffold(
              key: scaffoldKey,
              // App Bar
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 36,
                    )),
                title: GestureDetector(
                  onTap: () async {
                    fetchPickupList();
                  },
                  child: Image.asset(
                    'assets/images/logos/Xpr_Color.png',
                    width: 140,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                // actions: [ (value.isConnected) ?
                //   const Padding(
                //     padding: EdgeInsets.only(right: 8),
                //     child: Icon(Symbols.signal_wifi_4_bar_rounded),
                //   ) : const Padding(
                //     padding: EdgeInsets.only(right: 8),
                //     child: Icon(Symbols.signal_wifi_off_rounded),
                //   )
                // ],
              ),
              drawer: const XprDrawer(),
              body: SafeArea(
                child: Stack(
                  children: [
                    PopScope(
                        canPop: false,
                        onPopInvoked: (didPop) {
                          if (didPop) {
                            return;
                          }
                          //backBlock();
                          return;
                        },
                        child: const SizedBox.shrink()),

                    FlutterMap(
                      mapController: mapController,
                      options: const MapOptions(
                        initialCenter: LatLng(19.21615, 72.8186),
                        initialZoom: 8.5,
                        maxZoom: 22,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=10362232a61149a190a1c0f366a188aa',
                          additionalOptions: const {
                            'style': 'atlas',
                            'apiKey': '10362232a61149a190a1c0f366a188aa',
                          },
                          maxZoom: 22,
                          userAgentPackageName: 'com.example.xprapp',
                        ),
                        (_value == 0)
                            ? MarkerLayer(
                                markers: List.generate(
                                  markerCoords.values.toList().length,
                                  (index) => Marker(
                                    point: LatLng(
                                        markerCoords.values.toList()[index][0],
                                        markerCoords.values.toList()[index][1]),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                        onTap: () {
                                          animateOnTap(maxScrollHeight);
                                          listController.scrollTo(
                                              index: 20,
                                              duration:
                                                  const Duration(seconds: 2));
                                        },
                                        child: const Icon(
                                          Symbols.location_pin_rounded,
                                          size: 42,
                                          fill: 1,
                                        )),
                                  ),
                                ),
                              )
                            : MarkerLayer(
                                markers: [
                                  Marker(
                                    point: const LatLng(19.213827, 72.866847),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                        onTap: () {
                                          animateOnTap(maxScrollHeight);
                                          listController.scrollTo(
                                              index: 20,
                                              duration:
                                                  const Duration(seconds: 1));
                                        },
                                        child: const Icon(
                                          Symbols.location_pin_rounded,
                                          size: 42,
                                          fill: 1,
                                        )),
                                  ),
                                ],
                              )
                      ],
                    ),
                    (isLoading)
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
                        : const SizedBox.shrink(),
                    // Draggable Scrollable Sheet
                    DraggableScrollableSheet(
                      initialChildSize: minScrollHeight,
                      minChildSize: minScrollHeight,
                      maxChildSize: maxScrollHeight,
                      controller: dsController,
                      snap: true,
                      snapAnimationDuration: const Duration(milliseconds: 150),
                      builder: (context, scrollController) {
                        dsController.addListener(() {
                          final newSize = dsController.size;
                          final scrollPosition = ((newSize - minScrollHeight) /
                                  (maxScrollHeight - minScrollHeight))
                              .clamp(0.0, 1.0);

                          // setState(() {
                          //   scrollPosition > minScrollHeight + 0.02 ?
                          //   isMin = false : isMin = true;
                          // });
                          _animController.animateTo(scrollPosition,
                              duration: Duration.zero);
                        });

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)),
                            border: BorderDirectional(
                                top: BorderSide(
                                    color: lightColorScheme.outline, width: 2),
                                start: BorderSide(
                                    color: lightColorScheme.outline, width: 2),
                                end: BorderSide(
                                    color: lightColorScheme.outline, width: 2)),
                            gradient: LinearGradient(
                                colors: [
                                  lightColorScheme.surface,
                                  lightColorScheme.primaryContainer
                                ],
                                stops: const [
                                  0,
                                  1
                                ],
                                begin: const AlignmentDirectional(0, -1),
                                end: const AlignmentDirectional(0, 1)),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: //(isMin) ?
                                      //   TextButton(onPressed: () {
                                      //     animateOnTap(maxScrollHeight);
                                      //   }, child: const Text('View List'))
                                      // :
                                      Row(
                                    children: [
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Wrap(
                                        spacing: 12,
                                        children: List<Widget>.generate(
                                          2,
                                          (int index) {
                                            return ChoiceChip(
                                              label: Text(
                                                  MapState.values[index].val),
                                              showCheckmark: false,
                                              selected: _value == index,
                                              selectedColor:
                                                  lightColorScheme.secondary,
                                              labelStyle: TextStyle(
                                                  color: _value == index
                                                      ? Colors.white
                                                      : lightColorScheme
                                                          .onSurface),
                                              disabledColor: lightColorScheme
                                                  .surfaceVariant,
                                              onSelected: (bool selected) {
                                                selectChip(selected, index);
                                              },
                                            );
                                          },
                                        ).toList(),
                                      ),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      RotationTransition(
                                        turns: _rotationAnim,
                                        child: IconButton(
                                            onPressed: () {
                                              toggle();
                                            },
                                            icon: const Icon(
                                              Symbols.keyboard_arrow_up_rounded,
                                              size: 36,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 650,
                                  width: MediaQuery.sizeOf(context).width * .85,
                                  child: ScrollablePositionedList.builder(
                                    itemScrollController: listController,
                                    itemCount:
                                        (_value == 0) ? ptiles.length : 32,
                                    itemBuilder: (context, index) {
                                      if (_value == 0) {
                                        return MapTile(
                                          onTap: () => _showDialog(),
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
                                          tnum:
                                              ptiles[index].data.first.pickupNo,
                                          instructions: ptiles[index]
                                                  .data
                                                  .first
                                                  .specialinstructions ??
                                              "N/A",
                                          latlng:
                                              ptiles[index].data.first.latlng ??
                                                  const [1.0, 2.0],
                                          datetime:
                                              "${DateTime.parse(ptiles[index].data.first.pickupdate).day}/${DateTime.parse(ptiles[index].data.first.pickupdate).month}/${DateTime.parse(ptiles[index].data.first.pickupdate).year}, ${DateTime.parse(ptiles[index].data.first.pickupdate).hour}:${DateTime.parse(ptiles[index].data.first.pickupdate).minute}",
                                        );
                                      }
                                      return MapTile(
                                        state: false,
                                        index: index,
                                        onTap: () {
                                          Navigator.pushNamed(context, '/pod');
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
