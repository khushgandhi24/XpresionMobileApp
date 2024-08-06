import 'package:flutter/material.dart';

class ShipTile extends StatelessWidget {
  const ShipTile(
      {super.key,
      required this.date,
      required this.status,
      required this.area});

  final String date;
  final String status;
  final String area;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      leading: Icon(
        Icons.circle,
        color: Theme.of(context).colorScheme.secondary,
        size: 28,
      ),
      title: Text('$status | $area'),
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      subtitle: Text(date),
      subtitleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    );
  }
}
