import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/shared/awb_search.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/screens/pickup_in_scan/dropdown_entries.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:xprapp/theme.dart';

class PInScanModel {
  bool success;
  String message;

  PInScanModel({
    required this.success,
    required this.message,
  });

  factory PInScanModel.fromJson(Map<String, dynamic> json) =>
      PInScanModel(success: json['success'], message: json['message']);
}

class PInScan extends StatefulWidget {
  const PInScan({super.key});

  @override
  State<PInScan> createState() => _PInScanState();
}

class _PInScanState extends State<PInScan> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int count = 0;

  final TextEditingController statusController = TextEditingController();
  InScanStatus? selectedStatus;

  // Position? _location;
  // late bool servicePermission = false;
  // late LocationPermission permission;
  // String userLocation = '';
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  // Future<Position> _getLocation() async {
  //   servicePermission = await Geolocator.isLocationServiceEnabled();
  //   if(!servicePermission) {
  //     debugPrint('Location Permissions needed');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  // Future<void> fetchLocation() async {
  //   _location = await _getLocation();
  //   List<Placemark> placemarks = await placemarkFromCoordinates(_location!.latitude, _location!.longitude);
  //   setState(() {
  //     userLocation = placemarks.first.locality!;
  //   });
  // }

  @override
  void initState() {
    Provider.of<SearchModel>(context, listen: false).fetchLocation();
    super.initState();
  }

  void addCount() {
    setState(() {
      count++;
    });
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
              ),
              // Drawer
              drawer: const XprDrawer(),
              body: SafeArea(
                top: true,
                bottom: true,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              lightColorScheme.surface,
                              lightColorScheme.primaryContainer,
                            ],
                            stops: const [0, 1],
                            begin: const AlignmentDirectional(0, -1),
                            end: const AlignmentDirectional(0, 1),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () => value.fetchLocation(),
                                    child: const Icon(Symbols.location_pin)),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  value.userLocation,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                DropdownMenu(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  initialSelection: InScanStatus.pickup,
                                  controller: statusController,
                                  label: const Text('Status'),
                                  onSelected: (InScanStatus? status) {
                                    setState(() {
                                      selectedStatus = status;
                                      count = 0;
                                    });
                                  },
                                  dropdownMenuEntries: InScanStatus.values
                                      .map<DropdownMenuEntry<InScanStatus>>(
                                          (InScanStatus status) {
                                    return DropdownMenuEntry<InScanStatus>(
                                      value: status,
                                      label: status.val,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const AWBSearch(
                              page: 'scan',
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Tooltip(
                              key: tooltipkey,
                              triggerMode: TooltipTriggerMode.manual,
                              decoration: BoxDecoration(
                                  color: lightColorScheme.tertiary,
                                  borderRadius: BorderRadius.circular(6)),
                              preferBelow: true,
                              message:
                                  'Please submit AWB No. before pressing add entry',
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: TextButton(
                                  onPressed: () {
                                    if (value.query.isNotEmpty) {
                                      addCount();
                                      value.inScan();
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: (value.result.isNotEmpty
                                              ? Text(value.result)
                                              : count > 1
                                                  ? Text('$count AWBs added')
                                                  : Text('$count AWB added')),
                                          showCloseIcon: true,
                                          padding: const EdgeInsets.all(24),
                                          duration: const Duration(
                                              milliseconds: 3000),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight:
                                                      Radius.circular(24))),
                                        ));
                                      });
                                    } else {
                                      tooltipkey.currentState
                                          ?.ensureTooltipVisible();
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        Tooltip.dismissAllToolTips();
                                      });
                                    }
                                  },
                                  child: const Text('Add Entry'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
