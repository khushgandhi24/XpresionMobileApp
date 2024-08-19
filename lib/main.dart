// Imports for Theme, SplashScreen, State Management & Routing
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/screens/auth/forgot_pass.dart';
import 'package:xprapp/screens/auth/log_in.dart';
import 'package:xprapp/screens/awb_entry/awb_entry.dart';
import 'package:xprapp/screens/awb_entry/awb_new.dart';
import 'package:xprapp/screens/cloud/cloud_webview.dart';
import 'package:xprapp/screens/details/delivery.dart';
import 'package:xprapp/screens/details/pickup.dart';
import 'package:xprapp/screens/drs/drs.dart';
import 'package:xprapp/screens/home/a.dart';
import 'package:xprapp/screens/pickup_in_scan/pickup_in_scan.dart';
import 'package:xprapp/screens/pod_entry/pod_entry.dart';
import 'package:xprapp/screens/report/report.dart';
import 'package:xprapp/screens/track/track.dart';
import 'package:xprapp/services/awb_search_model.dart';
import 'package:xprapp/theme.dart';
import 'package:xprapp/views/awb/awb_webview.dart';
import 'package:xprapp/views/c_home.dart';
import 'package:xprapp/views/feedback/feedback.dart';
import 'package:xprapp/views/invoice/invoice.dart';
import 'package:xprapp/views/notifications/notification.dart';
import 'package:xprapp/views/profile/profile.dart';
import 'package:xprapp/views/quote/quote.dart';
import 'package:xprapp/views/reports/reports.dart';
import 'package:xprapp/views/tracking/tracking.dart';
import 'package:xprapp/views/watchlist/watchlist.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:upgrader/upgrader.dart';

Future main() async {
  // Ensuring Widget Binding to avoid errors during state management
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.storage.request();
  await Permission.notification.request();
  await Permission.photos.request();
  // await Permission.manageExternalStorage.request();
  await Permission.mediaLibrary.request();
  await Permission.phone.request();
  await Permission.location.request();
  await Permission.locationAlways.request();
  await Permission.locationWhenInUse.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Initializing Flutter Downloader
  await FlutterDownloader.initialize(
      debug:
          false, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  // Creating another binding instance to pass to SplashScreen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initialization(null);

  runApp(
      // ChangeNotifier used for managing state
      ChangeNotifierProvider(
    create: (context) => SearchModel(),
    child: MaterialApp(
      theme: primaryTheme,
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
        barrierDismissible: false,
        child: const LogIn(),
      ),
      // Using named routes for navigation
      routes: {
        '/login': (context) => const LogIn(),
        '/forgotPass': (context) => const ForgotPass(),
        '/mapHome': (context) => const XHome(),
        '/inScan': (context) => const PInScan(),
        '/track': (context) => const Track(),
        '/pickup': (context) => const Pickup(),
        '/delivery': (context) => const Delivery(),
        '/drs': (context) => const DRS(),
        '/pod': (context) => const PODEntry(),
        '/custHome': (context) => const CustomerHome(),
        '/getQuote': (context) => const Quote(),
        '/notifications': (context) => const Notifications(),
        '/profile': (context) => const Profile(),
        '/feedback': (context) => const FeedBack(),
        '/custTrack': (context) => const Tracking(),
        '/awb': (context) => const AWBEntry(),
        '/custAWB': (context) => const AWBWebView(),
        '/invoice': (context) => const Invoice(),
        '/reports': (context) => const Reports(),
        '/watchlist': (context) => const WatchList(),
        '/cloud': (context) => const CloudWebView(),
        '/report': (context) => const Report(),
        '/awbhome': (context) => const AWBHome(),
      },
    ),
  ));
}

// Initialization call to discard splashscreen after fixed duration

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(milliseconds: 500));
  FlutterNativeSplash.remove();
}
