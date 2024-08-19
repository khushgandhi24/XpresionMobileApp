import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/screens/awb_entry/awb_tile.dart';
import 'package:xprapp/screens/awb_entry/entry_page.dart';
import 'package:xprapp/screens/report/date_picker_field.dart';
import 'package:xprapp/shared/awb_search.dart';
import 'package:xprapp/shared/xpr_drawer.dart';

enum SearchFilter {
  awb("AWB No."),
  shipDate("Ship Date");

  final String name;
  const SearchFilter(this.name);
}

class AWBHome extends StatefulWidget {
  const AWBHome({super.key});

  @override
  State<AWBHome> createState() => _AWBHomeState();
}

class _AWBHomeState extends State<AWBHome> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       scaffoldKey.currentState!.openDrawer();
        //     },
        //     icon: Icon(
        //       Icons.menu_rounded,
        //       color: Theme.of(context).primaryColor,
        //       size: 36,
        //     )),
        title: Image.asset(
          'assets/images/logos/Xpr_Color.png',
          width: 140,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
      drawer: const XprDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const EntryPage(mode: true)));
        },
        label: const Text("Add AWB"),
        icon: Icon(
          Symbols.note_add_rounded,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            (_selectedValue == 0)
                ? const AWBSearch(page: "entry")
                : const DatePickerRow(),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 5,
              children: SearchFilter.values.map((SearchFilter option) {
                return ChoiceChip(
                  labelStyle: const TextStyle(color: Colors.white),
                  surfaceTintColor: Colors.transparent,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: AWBTile(),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
