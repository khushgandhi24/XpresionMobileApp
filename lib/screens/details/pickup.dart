import 'package:flutter/material.dart';
import 'package:xprapp/screens/details/tab_bar_view.dart';
import 'package:xprapp/shared/map_states.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/theme.dart';
// import 'package:dio/dio.dart';
// import 'package:xprapp/screens/home/home_model.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:geocoding/geocoding.dart';

// Dio dio = Dio(
//   BaseOptions(
//     baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
//   ),
// );

class Pickup extends StatefulWidget {
  const Pickup({super.key});

  @override
  State<Pickup> createState() => _PickupState();
}

class _PickupState extends State<Pickup> with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _tabController;

  // Future<void> _showDialog(bool isActive) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return PickupDialog(isActive: isActive,);
  //     }
  //   );
  // }

  // final storage = const FlutterSecureStorage();
  // List<PickupId> ptiles = [];

  // Future<List<double>> addrToLatLng(String addr) async {
  //   List<Location> locations = await locationFromAddress(addr);
  //   return [locations.last.latitude, locations.last.longitude];
  // }

  // Future<void> fetchPickupList() async {
    
  //   if (await storage.read(key: 'access_token') != '') {
  //     try {
  //       final res = await dio.get('/pickups/list', options: Options(headers: {'Authorization' : "Bearer ${await storage.read(key: 'access_token')}"}));
  //       PickupAll details = PickupAll.fromJson(res.data);
  //       //debugPrint(details.message);
  //       //debugPrint(details.data.length.toString());
  //       if (details.data.isNotEmpty) {
  //         //debugPrint(details.data.first.id.toString());
  //         var ids = [];
  //         var addrs = [];
  //         List<PickupId> pickups = [];
  //         for (int i = 0; i < details.data.length; i++) {
  //           ids.add(details.data[i].id);
  //         }
  //         //debugPrint(ids.toString());
  //         await Future.wait(ids.map((id) async {
  //           final resp = await dio.get('/pickups/$id',
  //             options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
  //             PickupId pdetail = PickupId.fromJson(resp.data);
  //             pdetail.data.first.latlng = await addrToLatLng("${pdetail.data.first.details.last.location.address1} ${pdetail.data.first.details.last.location.address2}");
  //             debugPrint(pdetail.data.first.latlng.toString());
  //             pickups.add(pdetail);
  //             addrs.add("${pdetail.data.first.details.last.location.address1} ${pdetail.data.first.details.last.location.address2}");
  //         }));
  //         //debugPrint(ids.toString());
  //         //debugPrint(addrs.toString());
  //         //debugPrint(DateTime.parse(pickups.first.data.first.pickupdate).toString());
  //         List<List<double>> latlng = [];
  //         await Future.wait(addrs.map((addr) async {
  //           latlng.add(await addrToLatLng(addr));
  //           //List<Location> locations = await locationFromAddress(addr);
  //           //latlng.add([locations.last.latitude, locations.last.longitude]);
  //         }));
  //         // final tlist = List.generate(ids.length, (index) => [ids[index], latlng[index]]);
  //         // debugPrint(tlist.toString());
  //         //debugPrint(latlng.toString());
  //         //debugPrint(pickups.first.data.first.latlng.toString());
  //         setState(() {
  //           ptiles = pickups;
  //         });

  //         // final pID = details.data.first.id.toString();
  //         // final rest = await dio.get('/pickups/$pID', options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
  //         //debugPrint(rest.data.toString());
  //         //PickupId pdetails = PickupId.fromJson(rest.data);
  //         //debugPrint(pdetails.data.first.contactperson);
  //       }
  //     } on DioException catch (e) {
  //       //debugPrint(e.message);
  //       if(e.response?.statusCode == 401) {
  //         debugPrint(await storage.read(key: 'access_token'));
  //         debugPrint(await storage.read(key: 'refresh_token'));
  //         debugPrint('Call starts');
  //         try {
  //           final rsp = await dio.post('/refreshtoken', data: {"refreshToken": await storage.read(key: "refresh_token")}, options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
  //           Token token = Token.fromJson(rsp.data);
  //           debugPrint('Call completes');
          
  //           if(token.success) {
  //             await storage.write(key: 'access_token', value: token.accesstoken.replaceAll('Bearer', '').trim());
  //             await storage.write(key: 'refresh_token', value: token.refreshtoken);
  //             //debugPrint(await storage.read(key: 'access_token'));
  //           }
  //           fetchPickupList();
  //         } on DioException catch(e) {
  //           if(e.response?.statusCode == 401) {
  //             if (!mounted) return;
  //             Navigator.push(context, MaterialPageRoute(builder: (ctx) => const LogIn()));
  //           }
  //         }
  //       }
  //     }
  //   }
  // }


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    //fetchPickupList();
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
          )
        ),
        title: Image.asset('assets/images/logos/Xpr_Color.png',
            width: 140,
            height: 70,
            fit: BoxFit.cover,
        ),
        bottom: TabBar(
          controller: _tabController, 
          tabs: List<Widget>.generate(
            3, (index) {
              return Tab(
                //text: MapState.values[0].modes[index],
                child: Text(MapState.values[0].modes[index],
                  style: TextStyle(fontSize: 14, color: (index != 2) ? ((index != 1) ? Colors.green : lightColorScheme.primary) : lightColorScheme.outline),
                ),
              );
            }
          )
        ),
      ),
      drawer: const XprDrawer(),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [
            PickupTBView(neww: true, show: false,),
            PickupTBView(show: true,),
            PickupTBView(history: true,show: false,)
          ],
        ),
      ),
    );
  }
}