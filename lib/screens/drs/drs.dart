import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/screens/drs/date_field.dart';
import 'package:xprapp/screens/drs/drs_form.dart';
import 'package:xprapp/screens/drs/drs_tile.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/theme.dart';

class DRS extends StatefulWidget {
  const DRS({super.key});

  @override
  State<DRS> createState() => _DRSState();
}

class _DRSState extends State<DRS> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      ),
      drawer: const XprDrawer(),
      body: SafeArea(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const DateField(label: 'DRS No.',),
                const SizedBox(height: 16,),
                Expanded(
                  child: ListView.builder(
                    itemCount: 32,
                    itemBuilder: (context, index) {
                      return const DRSTile();
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return const AddForm();
          });
        },
        backgroundColor: lightColorScheme.primary,
        shape: const CircleBorder(side: BorderSide(width: 0, color: Colors.transparent)),
        elevation: 4,
        enableFeedback: true,
        child: Icon(Symbols.add_rounded, color: lightColorScheme.onPrimary, size: 36,),
      ),
    );
  }
}