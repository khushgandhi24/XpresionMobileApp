import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/shared/menu_tile.dart';
import 'package:xprapp/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class XprDrawer extends StatelessWidget {
  const XprDrawer({super.key, this.mode = ''});

  final String mode;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
        builder: ((context, value, child) => SafeArea(
              child: Drawer(
                elevation: 16,
                width: MediaQuery.sizeOf(context).width * 0.80,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        lightColorScheme.surface,
                        lightColorScheme.secondaryContainer,
                      ],
                      stops: const [0, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/custHome');
                              },
                              child: Image.asset(
                                'assets/images/logos/App_Logo.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              (mode == 'cust') ? 'Username' : value.username,
                              style: TextStyle(
                                color: lightColorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Log out',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.1,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.2,
                                            child: const Text(
                                                'Are you sure you want to log out?'),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Provider.of<SearchModel>(
                                                          context,
                                                          listen: false)
                                                      .clearTokens();
                                                  await storage.write(
                                                      key: 'keepLoggedIn',
                                                      value: 'false');
                                                  if (!context.mounted) return;
                                                  Navigator.pushNamed(
                                                      context, '/login');
                                                },
                                                child: const Text('Yes')),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('No'))
                                          ],
                                          actionsAlignment:
                                              MainAxisAlignment.spaceAround,
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.logout_rounded,
                                  color: primaryTheme.colorScheme.onSurface,
                                  size: 32,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          child: GridView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: (mode == 'cust')
                                ? const [
                                    MenuTile(
                                        route: '/custAWB',
                                        icon: Symbols.edit_document_rounded,
                                        title: 'AWB\nEntry'),
                                    MenuTile(
                                      route: '/delivery',
                                      icon: Symbols.local_shipping_rounded,
                                      title: 'Delivery',
                                    ),
                                    MenuTile(
                                        route: '/invoice',
                                        icon: Symbols.receipt_long_rounded,
                                        title: 'Invoice'),
                                    MenuTile(
                                        route: '/reports',
                                        icon: Symbols.description_rounded,
                                        title: 'Report'),
                                    MenuTile(
                                        route: '/enquiry',
                                        icon: Symbols.info_rounded,
                                        title: "Enquiry"),
                                    MenuTile(
                                        route: '/feedback',
                                        icon: Symbols.thumbs_up_down_rounded,
                                        title: 'Feedback'),
                                    MenuTile(
                                        route: '/delivery',
                                        icon: Symbols.service_toolbox_rounded,
                                        title: 'Services'),
                                    MenuTile(
                                        route: '/delivery',
                                        icon: Symbols.info_rounded,
                                        title: 'About Us'),
                                    MenuTile(
                                      route: '/profile',
                                      icon: Symbols.account_circle_filled,
                                      title: 'Profile',
                                      fill: 1,
                                    ),
                                  ]
                                : const [
                                    MenuTile(
                                      route: '/mapHome',
                                      icon: Symbols.home_filled_rounded,
                                      title: 'Home',
                                    ),
                                    MenuTile(
                                        route: '/inScan',
                                        icon: Symbols.barcode_scanner_rounded,
                                        title: 'Pickup\nIn Scan'),
                                    MenuTile(
                                      route: '/awbhome',
                                      icon: Symbols.edit_document_rounded,
                                      title: 'AWB\nEntry',
                                    ),
                                    MenuTile(
                                        route: '/pod',
                                        icon: Symbols.signature_rounded,
                                        title: 'POD\nEntry'),
                                    MenuTile(
                                        route: '/track',
                                        icon: Symbols.travel_explore_rounded,
                                        title: 'Tracking'),
                                    MenuTile(
                                        route: '/pickup',
                                        icon: Symbols.pin_drop_rounded,
                                        title: 'Pickup'),
                                    MenuTile(
                                        route: '/delivery',
                                        icon: Symbols.local_shipping_rounded,
                                        title: 'Delivery'),
                                    MenuTile(
                                        route: '/drs',
                                        icon: Symbols.edit_document_rounded,
                                        title: 'DRS'),
                                    MenuTile(
                                        route: '/report',
                                        icon: Symbols.find_in_page_rounded,
                                        title: 'Reports'),
                                    MenuTile(
                                        route: '/manifest',
                                        icon: Symbols.lab_profile_rounded,
                                        title: 'Manifest'),
                                    MenuTile(
                                        route: '/minscan',
                                        icon: Symbols.document_scanner_rounded,
                                        title: 'Manifest\nIn Scan'),
                                  ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
