import 'package:flutter/material.dart';
import 'package:xprapp/shared/xpr_drawer.dart';
import 'package:xprapp/views/nav/navbar.dart';
import 'package:xprapp/views/notifications/notification_model.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final notifs = List<NotificationModel>.generate(10, (index) => NotificationModel(
    date: index.toString(), 
    userID: index.toString(), 
    notification: index.toString(), 
    time: index.toString())
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              child: Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
          ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ListView.builder(
              itemCount: notifs.length,
              itemBuilder: (context, index) {
                final item = notifs[index];
                return Dismissible(
                  key: Key(item.notification),
                  //background: Container(color: Theme.of(context).colorScheme.tertiary,),
                  onDismissed: (direction) {
                    setState(() {
                      notifs.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notification Deleted!'), duration: Durations.long2,)
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Theme.of(context).colorScheme.onTertiaryContainer, width: 2)
                      ),
                      child: Column(
                        children: [
                          Text(item.date),
                          const SizedBox(height: 12,),
                          Text(item.time),
                          const SizedBox(height: 12,),
                          Text(item.userID),
                          const SizedBox(height: 12,),
                          Text(item.notification),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar()
    );
  }
}