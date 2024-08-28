import 'package:flutter/material.dart';
import 'package:xprapp/views/nav/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: scaffoldKey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 90,
        title: Image.asset(
          'assets/images/logos/Xpr.png',
          width: 140,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
          child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.secondaryContainer
              ],
              stops: const [
                0,
                1
              ],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(hintText: "From Date"),
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(hintText: "From Date"),
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Search")),
                  const SizedBox(
                    width: 36,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text("Reset"))
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
