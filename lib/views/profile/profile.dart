import 'package:flutter/material.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: 16),),
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
                    const SizedBox(height: 24,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Username', style: TextStyle(fontSize: 15)),
                          Text ('Code: 2401', style: TextStyle(fontSize: 15)),
                          // RichText(text: const TextSpan(
                          //   text: 'Code: ',
                          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                          //   children: <TextSpan>[
                          //     TextSpan(text: '2401', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black))
                          //   ],
                          // ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(alignment: Alignment.centerLeft, child: Text('xyz_abc@xpresion.in')),
                    ),
                    // TextFormField(
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     hintText: 'xyz_abc@xpresion.in',
                    //     hintStyle: const TextStyle(color: Colors.black),
                    //     //labelText: 'Email ID',
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     disabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(24),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20,),
                    TextFormField(),
                    const SizedBox(height: 20,),
                    TextFormField(),
                    const SizedBox(height: 20,),
                    TextFormField(),
                    const SizedBox(height: 20,),
                    TextFormField(),
                    const SizedBox(height: 20,),
                    TextFormField(),
                    const SizedBox(height: 20,),
                    TextButton(onPressed: () {}, child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      child: Text('Save'),
                    ))
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