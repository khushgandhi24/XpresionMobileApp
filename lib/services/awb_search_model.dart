import 'dart:io';
import 'package:dart_casing/dart_casing.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:xprapp/screens/home/a.dart';
import 'package:dio/dio.dart';
import 'package:xprapp/screens/home/home_model.dart';
import 'package:xprapp/screens/pickup_in_scan/pickup_in_scan.dart';
import 'package:xprapp/screens/track/shipment_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://d1p54jp4j06wmy.cloudfront.net',
  ),
);

class SearchModel extends ChangeNotifier {
  String _query = '';

  String _username = '';

  String get username => _username;

  String get query => _query;

  String _valid = '';

  String get valid => _valid;

  bool _isTracking = true;

  bool get isTracking => _isTracking;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _result = '';

  String get result => _result;

  Shipment _shipment = Shipment(success: true, message: 'N/A', data: [
    ShipDatum(
        transactionstatus: 'N/A',
        transactiondate: 'N/A',
        transactiontime: 'N/A')
  ]);

  Shipment get shipment => _shipment;

  Position? _location;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _userLocation = '';
  String get userLocation => _userLocation;

  void onSubmit(String query, String mode) {
    _query = query;
    if (mode == 'track') {
      trackShipment();
    }
    if (mode == 'scan') {
      _result = '';
    }
    notifyListeners();
  }

  void reset() {
    _query = '';
  }

  void storeUsername(String uname) async {
    await _storage.write(key: 'username', value: uname);
    _username = uname;
    notifyListeners();
  }

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Future<bool> checkIsConnected() async {
    if (kIsWeb) {
      try {
        final res = await http.get(Uri.parse('www.google.com'));
        if (res.statusCode == 200) {
          _isConnected = true;
          return true;
        }
      } on SocketException {
        _isConnected = false;
        return false;
      }
    }
    try {
      final res = await InternetAddress.lookup('google.com');
      if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
        _isConnected = true;
        return true;
      }
    } on SocketException {
      _isConnected = false;
      return false;
    }
    return false;
  }

  final _storage = const FlutterSecureStorage();

  get storage => _storage;

  Future getTokens(
      String accToken, String refToken, String uID, String currentState) async {
    await _storage.write(key: 'access_token', value: accToken);
    await _storage.write(key: 'refresh_token', value: refToken);
    await _storage.write(key: 'user_ID', value: uID);
    await _storage.write(key: 'keepLoggedIn', value: currentState);
  }

  void clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'user_ID');
    notifyListeners();
  }

  void autoLogIn(BuildContext context, String currentStatus) async {
    if (currentStatus == 'true') {
      _username = await _storage.read(key: 'username') ?? "";
      debugPrint(_username);
      debugPrint(await _storage.read(key: 'username'));
      if (!context.mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const XHome()));
    }
  }

  Future trackShipment() async {
    _isLoading = true;
    notifyListeners();
    if (query.isNotEmpty && await storage.read(key: 'access_token') != '') {
      try {
        final res = await dio.get('/awb/tracking/progress?awbnumber=$query',
            options: Options(headers: {
              'Authorization':
                  'Bearer ${await storage.read(key: 'access_token')}'
            }));
        debugPrint("Call Finished");
        Shipment shipment = Shipment.fromJson(res.data);
        if (shipment.data.isEmpty) {
          reset();
          _isLoading = false;
          //debugPrint('Call failed');
          _valid =
              'Invalid AWB Number\nPlease enter a valid number\nand try again!';
          _isTracking = true;
          debugPrint('$_isTracking');
          notifyListeners();
        } else {
          _isLoading = false;
          _valid = "";
          debugPrint('Call success');
          shipment.data.first.transactionstatus = Casing.titleCase(
              shipment.data.first.transactionstatus.replaceAll("_", " "));
          shipment.data.first.transactiondate =
              "${DateTime.parse(shipment.data.first.transactiondate).day}/${DateTime.parse(shipment.data.first.transactiondate).month}/${DateTime.parse(shipment.data.first.transactiondate).year}";
          //debugPrint(shipment.data.first.transactionstatus);
          _shipment = shipment;
          _isTracking = false;
          notifyListeners();
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          debugPrint(await storage.read(key: 'access_token'));
          debugPrint(await storage.read(key: 'refresh_token'));
          debugPrint('Call starts');
          try {
            final rsp = await dio.post('/refreshtoken',
                data: {
                  "refreshToken": await storage.read(key: "refresh_token")
                },
                options: Options(headers: {
                  'Authorization':
                      "Bearer ${await storage.read(key: 'access_token')}"
                }));
            Token token = Token.fromJson(rsp.data);
            debugPrint('Call completes');

            if (token.success) {
              await storage.write(
                  key: 'access_token',
                  value: token.accesstoken.replaceAll('Bearer', '').trim());
              await storage.write(
                  key: 'refresh_token', value: token.refreshtoken);
              //debugPrint(await storage.read(key: 'access_token'));
            }
            trackShipment();
          } on DioException catch (e) {
            if (e.response?.statusCode == 401) {
              //if (!mounted) return;
              //Navigator.push(context, MaterialPageRoute(builder: (ctx) => const LogIn()));
            }
          }
        }
      }
    }
  }

  void inScan() async {
    if (query.isNotEmpty && await storage.read(key: 'access_token') != '') {
      try {
        debugPrint('Start Scan');
        final res = await dio.post('/awb/inscan',
            options: Options(headers: {
              "Authorization":
                  'Bearer ${await storage.read(key: 'access_token')}'
            }),
            data: {
              "awbnumber": query,
            });

        PInScanModel awb = PInScanModel.fromJson(res.data);
        debugPrint('Finish Scan');
        if (!awb.success) {
          debugPrint('already scanned');
          _result = 'AWB is either incorrect or has already been scanned!';
          //reset();
          notifyListeners();
        }
      } on DioException catch (e) {
        debugPrint(e.message);
        if (e.response?.statusCode == 401) {
          debugPrint(await storage.read(key: 'access_token'));
          debugPrint(await storage.read(key: 'refresh_token'));
          debugPrint('Call starts');
          try {
            final rsp = await dio.post('/refreshtoken',
                data: {
                  "refreshToken": await storage.read(key: "refresh_token")
                },
                options: Options(headers: {
                  'Authorization':
                      "Bearer ${await storage.read(key: 'access_token')}"
                }));
            Token token = Token.fromJson(rsp.data);
            debugPrint('Call completes');

            if (token.success) {
              await storage.write(
                  key: 'access_token',
                  value: token.accesstoken.replaceAll('Bearer', '').trim());
              await storage.write(
                  key: 'refresh_token', value: token.refreshtoken);
              //debugPrint(await storage.read(key: 'access_token'));
            }
            inScan();
          } on DioException catch (e) {
            if (e.response?.statusCode == 401) {
              //if (!mounted) return;
              //Navigator.push(context, MaterialPageRoute(builder: (ctx) => const LogIn()));
            }
          }
        }
      }
    }
  }

  Future<Position> _getLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      debugPrint('Location Permissions needed');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    debugPrint('Geolocator Call Start');
    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchLocation() async {
    _location = await _getLocation();
    debugPrint('Geolocator Call End');
    debugPrint('Getting user location');
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _location!.latitude, _location!.longitude);
    debugPrint('Setting user location');
    _userLocation = placemarks.first.locality!;
    notifyListeners();
  }
}

class PickupModel extends ChangeNotifier {}
