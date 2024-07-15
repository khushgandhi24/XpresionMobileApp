import 'package:flutter/material.dart';
import 'package:xprapp/screens/details/tab_bar_view.dart';
import 'package:xprapp/screens/home/map_tile.dart';
import 'package:xprapp/screens/details/delivery_detail_tile.dart';
import 'package:xprapp/screens/pod_entry/pod_entry.dart';
import 'package:xprapp/shared/map_states.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xprapp/screens/details/delivery_model.dart';
import 'package:xprapp/screens/home/home_model.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _tabController;

  bool isLoading = false;
  final storage = const FlutterSecureStorage();

  Future<void> fetchDeliveryList() async {
    setState(() {
      isLoading = true;
    });
    if (await storage.read(key: 'access_token') != '') {
      try {
        final res = await dio.get('/drs/awb/details',
            options: Options(headers: {
              'Authorization':
                  'Bearer ${await storage.read(key: 'access_token')}'
            }));
        DeliveryAll details = DeliveryAll.fromJson(res.data);
        if (details.data.isNotEmpty) {
          return;
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
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 76,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Theme.of(context).primaryColor,
              size: 32,
            )),
        title: Image.asset(
          'assets/images/logos/Xpr_Color.png',
          width: 140,
          height: 70,
          fit: BoxFit.cover,
        ),
        bottom: TabBar(
            controller: _tabController,
            tabs: List<Widget>.generate(3, (index) {
              return Tab(
                //text: MapState.values[1].modes[index],
                child: Text(
                  MapState.values[1].modes[index],
                  style: TextStyle(
                      fontSize: 14,
                      color: (index != 2)
                          ? ((index != 1) ? Colors.red : Colors.green)
                          : lightColorScheme.outline),
                ),
              );
            })),
      ),
      drawer: const XprDrawer(),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            DeliveryTBView(MapTile(
              state: false,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PODEntry(),
                    ));
              },
            )),
            DeliveryTBView(
                DeliveryDetailTile(mode: MapState.values.last.modes[1])),
            DeliveryTBView(
                DeliveryDetailTile(mode: MapState.values.last.modes.last)),
          ],
        ),
      ),
    );
  }
}
