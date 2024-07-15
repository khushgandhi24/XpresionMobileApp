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

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

class PickupTBView extends StatefulWidget {
  const PickupTBView({super.key, this.history = false, this.neww = false, required this.show});

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
        final res = await dio.get('/pickups/list', options: Options(headers: {'Authorization' : "Bearer ${await storage.read(key: 'access_token')}"}));
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
              options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
              PickupId pdetail = PickupId.fromJson(resp.data);
              pdetail.data.first.latlng = await addrToLatLng("${pdetail.data.first.details.last.location.address1} ${pdetail.data.first.details.last.location.address2}");
              //debugPrint(pdetail.data.first.latlng.toString());
              pickups.add(pdetail);
              addrs.add("${pdetail.data.first.details.last.location.address1} ${pdetail.data.first.details.last.location.address2}");
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
        if(e.response?.statusCode == 401) {
          try {
            final rsp = await dio.post('/refreshtoken', data: {"refreshToken": await storage.read(key: "refresh_token")}, options: Options(headers: {'Authorization': "Bearer ${await storage.read(key: 'access_token')}"}));
            Token token = Token.fromJson(rsp.data);
            debugPrint('Call completes');
          
            if(token.success) {
              await storage.write(key: 'access_token', value: token.accesstoken.replaceAll('Bearer', '').trim());
              await storage.write(key: 'refresh_token', value: token.refreshtoken);
            }
            fetchPickupList();
          } on DioException catch(e) {
            if(e.response?.statusCode == 401) {
              setState(() {
                isLoading = false;
              });
              await storage.write(key: 'keepLoggedIn', value: 'false');
              if (!mounted) return;
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => const LogIn()));
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
        return PickupDialog(isActive: isActive,);
      }
    );
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
                  colors: [
                    lightColorScheme.surface,
                    lightColorScheme.primaryContainer
                  ],
                  stops: const [0, 1],
                  begin: const AlignmentDirectional(0, -1),
                  end: const AlignmentDirectional(0, 1),
                ),
              ),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  const AWBSearch(page: 'pickup/delivery',),
                  const SizedBox(height: 16,),
                  (isLoading) ? Center(
                    child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05, width: MediaQuery.sizeOf(context).width * 0.1, child: CircularProgressIndicator(strokeWidth: 4,value: null, color: lightColorScheme.inverseSurface,)),
                  ) :
                  Expanded(
                    child: ScrollablePositionedList.builder(
                      itemCount: ptiles.length,
                      itemScrollController: pickupController,
                      itemBuilder: (context, int index) {
                        return MapTile(isHistory: widget.history, isNew: widget.neww, onTap: () => _showDialog(widget.show),
                          person: ptiles[index].data.first.contactperson,
                          address: "${ptiles[index].data.first.details.last.location.address1} ${ptiles[index].data.first.details.last.location.address2}",
                          area: ptiles[index].data.first.details.last.location.area ?? "N/A",
                          mobileno: ptiles[index].data.first.details.last.location.mobileno.toString(),
                          tnum: ptiles[index].data.first.pickupNo,
                          instructions: ptiles[index].data.first.specialinstructions ?? "N/A",
                          latlng: ptiles[index].data.first.latlng ?? const [1.0, 2.0],
                          datetime: "${DateTime.parse(ptiles[index].data.first.pickupdate).day}/${DateTime.parse(ptiles[index].data.first.pickupdate).month}/${DateTime.parse(ptiles[index].data.first.pickupdate).year}, ${DateTime.parse(ptiles[index].data.first.pickupdate).hour}:${DateTime.parse(ptiles[index].data.first.pickupdate).minute}",
                        );
                      }
                    ),
                  ),
                ],
              ),
            );
  }
}

class DeliveryTBView extends StatelessWidget {
  const DeliveryTBView(this.tile, {super.key});

  final Widget tile;

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightColorScheme.surface,
                    lightColorScheme.primaryContainer
                  ],
                  stops: const [0, 1],
                  begin: const AlignmentDirectional(0, -1),
                  end: const AlignmentDirectional(0, 1),
                ),
              ),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  const AWBSearch(page: 'pickup/delivery',),
                  const SizedBox(height: 16,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 16,
                      itemBuilder: (context, int index) {
                        return tile;
                      }
                    ),
                  ),
                ],
              ),
            );
  }
}
