import 'package:flutter/material.dart';
import 'package:xprapp/screens/manifest/filter.dart';
import 'package:xprapp/screens/manifest/inscan_tile.dart';
import 'package:xprapp/shared/xpr_drawer.dart';

class ManifestInscan extends StatefulWidget {
  const ManifestInscan({super.key});

  @override
  State<ManifestInscan> createState() => _ManifestInscanState();
}

class _ManifestInscanState extends State<ManifestInscan> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool showFilters = false;
  int _selectedValue = 0;

  void togglefilters() {
    setState(() {
      showFilters = !showFilters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
      drawer: const XprDrawer(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // Text("Manifest In Scan"),
            // const SizedBox(
            //   height: 12,
            // ),
            Row(
              children: [
                Expanded(child: TextField()),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                    onPressed: togglefilters,
                    icon: (!showFilters)
                        ? Icon(Icons.filter_alt_rounded)
                        : Icon(Icons.filter_alt_off_rounded)),
              ],
            ),
            (showFilters)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Wrap(
                      spacing: 32,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children:
                          ManifestFilter.values.map((ManifestFilter option) {
                        return ChoiceChip(
                          // checkmarkColor: Colors.white,
                          showCheckmark: false,
                          labelStyle: const TextStyle(color: Colors.white),
                          surfaceTintColor: Colors.transparent,
                          selectedColor: Theme.of(context).colorScheme.primary,
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          label: Text(option.name),
                          selected: _selectedValue == option.index,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedValue = selected ? option.index : 0;
                              debugPrint(_selectedValue.toString());
                            });
                          },
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: InscanTile(),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
