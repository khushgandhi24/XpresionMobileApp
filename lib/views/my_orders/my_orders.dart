import 'package:flutter/material.dart';
import 'package:xprapp/views/my_orders/order_tile.dart';
import 'package:xprapp/views/nav/navbar.dart';

enum OrderFilter {
  active("Active"),
  completed("Completed");

  final String name;
  const OrderFilter(this.name);
}

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedValue = 0;
  int activeIndex = 0;
  int compIndex = 0;

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
              Wrap(
                spacing: 22,
                children: OrderFilter.values.map((OrderFilter option) {
                  return ChoiceChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    checkmarkColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.white),
                    surfaceTintColor: Colors.transparent,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    label: Text(option.name),
                    padding: const EdgeInsets.all(12),
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
              (_selectedValue == 0)
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Row(
                        children: [
                          Expanded(child: TextField()),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(child: TextField())
                        ],
                      ),
                    ),
              (_selectedValue == 0)
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, activeIndex) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: OrderTile(
                                  active: true,
                                ),
                              );
                            }),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, compIndex) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: OrderTile(),
                              );
                            }),
                      ),
                    )
            ],
          ),
        ),
      )),
    );
  }
}
