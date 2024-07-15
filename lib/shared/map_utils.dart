import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapUtils extends StatelessWidget {
  const MapUtils({super.key, this.isNew = false, this.mobileno = '', this.latlng = const [1.0,2.0]});

  final bool isNew;
  final String mobileno;
  final List<double> latlng;

  final String message = 'Test Message';

  void makeCall() async {
    final number = Uri.parse("tel:$mobileno");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      throw 'Could not make call';
    }
  }

  
  void _sendSMS() async {
  var url = Uri(scheme: 'sms', path: mobileno, queryParameters: <String, String>{
    'body': Uri.encodeComponent('Messafe'),
  });
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector( onTap: () => makeCall(),
                  child: const Icon(Symbols.call_rounded, color: Colors.lightGreen, size: 40, fill: 1)),
                (!isNew) ?
                  GestureDetector(onTap: () => _sendSMS(),
                    child: const Icon(Symbols.message_rounded, color: Colors.amberAccent, size: 40, fill: 1,))
                :
                  const Wrap(
                    spacing: 45,
                    children: [
                      Icon(Symbols.check_circle_rounded, color : Colors.green, size: 40, fill: 1,),
                      Icon(Symbols.cancel_rounded, color : Colors.redAccent, size: 40, fill: 1,),
                    ],
                  ),
                GestureDetector( onTap: () => MapsLauncher.launchCoordinates(latlng[0], latlng[1]),
                  child: const Icon(Symbols.navigation_rounded, color: Colors.blueAccent, size: 40, fill: 1,)),
              ],
            );
  }
}