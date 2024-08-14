import "package:flutter/material.dart";
import 'package:xprapp/screens/report/date_picker_field.dart';
import "package:xprapp/shared/xpr_drawer.dart";
import 'package:xprapp/services/awb_search_model.dart';
import 'package:provider/provider.dart';

class Report extends StatelessWidget {
  const Report({super.key});

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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DatePickerRow(),
                  SizedBox(
                    height: 12,
                  ),
                  DatePickerRow(),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ))));
  }
}
