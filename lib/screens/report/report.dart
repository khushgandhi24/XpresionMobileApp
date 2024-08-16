import "package:flutter/material.dart";
import 'package:xprapp/screens/report/date_picker_field.dart';
import 'package:xprapp/screens/report/report_list.dart';
import "package:xprapp/shared/xpr_drawer.dart";
import 'package:xprapp/services/awb_search_model.dart';
import 'package:provider/provider.dart';

enum CustNames {
  c1("Customer 1"),
  c2("Customer 2"),
  c3("Customer 3"),
  c4("Customer 4"),
  c5("Customer 5"),
  c6("Customer 6");

  const CustNames(this.name);
  final String name;
}

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();
    return Consumer<SearchModel>(
        builder: (context, value, child) => Scaffold(
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
            // Drawer
            drawer: const XprDrawer(),
            body: SafeArea(
                child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const DatePickerRow(),
                    const SizedBox(
                      height: 18,
                    ),
                    const DatePickerRow(),
                    const SizedBox(
                      height: 18,
                    ),
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      dropdownMenuEntries: CustNames.values
                          .map<DropdownMenuEntry<CustNames>>((CustNames name) {
                        return DropdownMenuEntry<CustNames>(
                          value: name,
                          label: name.name,
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    (!isSelected)
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: 12,
                                itemBuilder: (context, val) {
                                  return ReportTile();
                                }),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ))));
  }
}
