import "package:flutter/material.dart";
import "package:xprapp/shared/xpr_drawer.dart";
import "package:xprapp/views/nav/navbar.dart";

class EnquiryForm extends StatefulWidget {
  const EnquiryForm({super.key});

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: scaffoldKey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        )),
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
            )),
        title: Image.asset(
          'assets/images/logos/Xpr.png',
          width: 140,
          height: 70,
          fit: BoxFit.cover,
        ),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Enquiry",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ))),
      ),
      drawer: const XprDrawer(
        mode: 'cust',
      ),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
          child: Container(
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
                end: const AlignmentDirectional(0, 1))),
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Phone No."),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Description"),
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Submit"))
                  ],
                ),
              ),
            )),
      )),
    );
  }
}
