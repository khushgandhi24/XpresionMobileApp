import 'package:flutter/material.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';
import 'package:xprapp/views/quote/weights.dart';

class Quote extends StatefulWidget {
  const Quote({super.key});

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final dropdownController = TextEditingController();
  Weights? selectedWeight;

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
      ),
      drawer: const XprDrawer(mode: 'cust',),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.secondaryContainer],
              stops: const[0,1],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1)
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 36,),
                  const Align(alignment: AlignmentDirectional(-1, 0), child: Text('Shipment Quote', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                  const SizedBox(height: 36,),
                  TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                    ),
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: const InputDecoration(                     
                      labelText: 'Deliver To',                      
                      hintText: 'Enter destination...',                     
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the client ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 36,),
                  DropdownMenu(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    controller: dropdownController,
                    label: const Text('Shipment Weight'),
                    onSelected: (Weights? weight) {
                      setState(() {
                        selectedWeight = weight;
                      });
                    },
                    dropdownMenuEntries: Weights.values
                      .map<DropdownMenuEntry<Weights>>(
                        (Weights weight) {
                          return DropdownMenuEntry<Weights>(
                            value: weight,
                            label: weight.val,
                          );
                        }
                      ).toList(),
                  ),
                  const SizedBox(height: 36,),
                  TextButton(onPressed: () {}, 
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.sizeOf(context).width * 0.35,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Get Quote'),
                          Icon(Icons.arrow_forward_rounded)
                        ],
                      ),
                    ))
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}