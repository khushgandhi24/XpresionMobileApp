import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/theme.dart';

class XAlert extends StatelessWidget {
  const XAlert({super.key, this.body = '', this.head = '' });

  final String body;
  final String head;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: head == '' ? null : Text(head, style: TextStyle(color: lightColorScheme.primary, fontSize: 15),),
      content: Text(body, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13),),
      actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Done')),
      ],
      icon: const Icon(Symbols.location_pin_rounded, fill: 1, size: 36,),
      surfaceTintColor: Colors.transparent,
      backgroundColor: lightColorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 8,
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
    );
  }
}