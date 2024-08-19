import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class EntryTile extends StatefulWidget {
  const EntryTile({super.key, required this.title, required this.route});

  final String title;
  final String route;

  @override
  State<EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 4)),
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        onTap: () {
          // Navigator.pushNamed(context, widget.route);
        },
        title: Text(widget.title),
        trailing: Icon(
          Symbols.check_circle_outline,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
