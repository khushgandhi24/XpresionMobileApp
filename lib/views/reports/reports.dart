import 'package:flutter/material.dart';
import 'package:xprapp/screens/drs/date_field.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';
import 'package:xprapp/views/reports/reports_dropdown.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {

  final reportController = TextEditingController();
  ReportsList? selectedReport;

  final holdController = TextEditingController();
  final destController = TextEditingController();
  final prodController = TextEditingController();
  final vendorController = TextEditingController();
  final servController = TextEditingController();
  final typeController = TextEditingController();
  final statusController = TextEditingController();
  

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      selectedReport = null;
    });
    super.initState();
  }

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
              child: Text('View Reports', style: TextStyle(color: Colors.white, fontSize: 16),),
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
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      initialSelection: ReportsList.ledger,
                      controller: reportController,
                      label: const Text('Report Type'),
                      onSelected: (ReportsList? report) {
                        setState(() {
                          selectedReport = report;
                        });
                      },
                      dropdownMenuEntries: ReportsList.values
                        .map<DropdownMenuEntry<ReportsList>>(
                          (ReportsList report) {
                            return DropdownMenuEntry<ReportsList>(
                              value: report,
                              label: report.val,
                            );
                          }
                        ).toList(),
                    ),
                    const SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.sizeOf(context).width * 0.451, child: const DateField(label: 'From', sficon: false,)),
                          SizedBox(width: MediaQuery.sizeOf(context).width * 0.451, child: const DateField(label: 'To', sficon: false,)),
                        ],
                      ),
                      const SizedBox(height: 20,),
                    (selectedReport != ReportsList.ledger) ? (selectedReport == ReportsList.awbHold) ?
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      initialSelection: ReportsList.ledger,
                      controller: holdController,
                      label: const Text('Report Type'),
                      onSelected: (ReportsList? report) {
                        setState(() {
                          selectedReport = report;
                        });
                      },
                      dropdownMenuEntries: ReportsList.values
                        .map<DropdownMenuEntry<ReportsList>>(
                          (ReportsList report) {
                            return DropdownMenuEntry<ReportsList>(
                              value: report,
                              label: report.val,
                            );
                          }
                        ).toList(),
                    ) : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              child: TextFormField()),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              child: TextFormField()),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              child: TextFormField()),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              child: TextFormField()),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              initialSelection: ReportsList.ledger,
                              controller: destController,
                              label: const Text('Destination'),
                              onSelected: (ReportsList? report) {
                                setState(() {
                                  selectedReport = report;
                                });
                              },
                              dropdownMenuEntries: ReportsList.values
                                .map<DropdownMenuEntry<ReportsList>>(
                                  (ReportsList report) {
                                    return DropdownMenuEntry<ReportsList>(
                                      value: report,
                                      label: report.val,
                                    );
                                  }
                                ).toList(),
                            ),
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              initialSelection: ReportsList.ledger,
                              controller: prodController,
                              label: const Text('Product'),
                              onSelected: (ReportsList? report) {
                                setState(() {
                                  selectedReport = report;
                                });
                              },
                              dropdownMenuEntries: ReportsList.values
                                .map<DropdownMenuEntry<ReportsList>>(
                                  (ReportsList report) {
                                    return DropdownMenuEntry<ReportsList>(
                                      value: report,
                                      label: report.val,
                                    );
                                  }
                                ).toList(),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              initialSelection: ReportsList.ledger,
                              controller: vendorController,
                              label: const Text('Vendor'),
                              onSelected: (ReportsList? report) {
                                setState(() {
                                  selectedReport = report;
                                });
                              },
                              dropdownMenuEntries: ReportsList.values
                                .map<DropdownMenuEntry<ReportsList>>(
                                  (ReportsList report) {
                                    return DropdownMenuEntry<ReportsList>(
                                      value: report,
                                      label: report.val,
                                    );
                                  }
                                ).toList(),
                            ),
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              initialSelection: ReportsList.ledger,
                              controller: servController,
                              label: const Text('Service'),
                              onSelected: (ReportsList? report) {
                                setState(() {
                                  selectedReport = report;
                                });
                              },
                              dropdownMenuEntries: ReportsList.values
                                .map<DropdownMenuEntry<ReportsList>>(
                                  (ReportsList report) {
                                    return DropdownMenuEntry<ReportsList>(
                                      value: report,
                                      label: report.val,
                                    );
                                  }
                                ).toList(),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              initialSelection: ReportsList.ledger,
                              controller: typeController,
                              label: const Text('Delivery Type'),
                              onSelected: (ReportsList? report) {
                                setState(() {
                                  selectedReport = report;
                                });
                              },
                              dropdownMenuEntries: ReportsList.values
                                .map<DropdownMenuEntry<ReportsList>>(
                                  (ReportsList report) {
                                    return DropdownMenuEntry<ReportsList>(
                                      value: report,
                                      label: report.val,
                                    );
                                  }
                                ).toList(),
                            ),
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.425,
                              initialSelection: ReportsList.ledger,
                              controller: statusController,
                              label: const Text('AWB Status'),
                              onSelected: (ReportsList? report) {
                                setState(() {
                                  selectedReport = report;
                                });
                              },
                              dropdownMenuEntries: ReportsList.values
                                .map<DropdownMenuEntry<ReportsList>>(
                                  (ReportsList report) {
                                    return DropdownMenuEntry<ReportsList>(
                                      value: report,
                                      label: report.val,
                                    );
                                  }
                                ).toList(),
                            ),
                          ],
                        ),
                      ],
                    )
                    :
                    const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}