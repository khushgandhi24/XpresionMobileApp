import 'package:flutter/material.dart';
import 'package:xprapp/screens/drs/date_field.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/invoice/invoice_dropdown.dart';
import 'package:xprapp/views/invoice/invoice_tile.dart';
import 'package:xprapp/views/nav/navbar.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final yearController = TextEditingController();
  InvoiceYear? selectedYear;

  final compController = TextEditingController();
  InvoiceCompany? selectedComp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: scaffoldKey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          }, 
          icon: Icon(
            Icons.menu_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 36,
          )
        ),
        title: Image.asset('assets/images/logos/Xpr.png',
            width: 140,
            height: 70,
            fit: BoxFit.cover,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text('View Invoice', style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
          ),
        ),
      ),
      drawer: const XprDrawer(mode: 'cust',),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.secondaryContainer],
              stops: const[0,1],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1)
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.451, child: const DateField(label: 'From', sficon: false,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.451, child: const DateField(label: 'To', sficon: false,)),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      initialSelection: InvoiceCompany.busisoft,
                      controller: compController,
                      label: const Text('Company'),
                      onSelected: (InvoiceCompany? company) {
                        setState(() {
                          selectedComp = company;
                        });
                      },
                      dropdownMenuEntries: InvoiceCompany.values
                        .map<DropdownMenuEntry<InvoiceCompany>>(
                          (InvoiceCompany company) {
                            return DropdownMenuEntry<InvoiceCompany>(
                              value: company,
                              label: company.name,
                            );
                          }
                        ).toList(),
                    ),
                    const SizedBox(height: 20,),
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      initialSelection: InvoiceYear.twentyThreeFour,
                      controller: yearController,
                      label: const Text('Year'),
                      onSelected: (InvoiceYear? year) {
                        setState(() {
                          selectedYear = year;
                        });
                      },
                      dropdownMenuEntries: InvoiceYear.values
                        .map<DropdownMenuEntry<InvoiceYear>>(
                          (InvoiceYear year) {
                            return DropdownMenuEntry<InvoiceYear>(
                              value: year,
                              label: year.year,
                            );
                          }
                        ).toList(),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      //padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        //color: Colors.black,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      child: ListView.builder(
                        itemBuilder: (context, count) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: InvoiceTile(),
                          );
                        }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}