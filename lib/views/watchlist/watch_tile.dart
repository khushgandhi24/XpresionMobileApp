import 'package:flutter/material.dart';

class WatchTile extends StatefulWidget {
  const WatchTile({super.key});

  @override
  State<WatchTile> createState() => _WatchTileState();
}

class _WatchTileState extends State<WatchTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer, width: 2),
          borderRadius: BorderRadius.circular(24)
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: RichText(
              text: TextSpan(
                text: 'AWB No.: ', 
                style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSecondaryContainer), 
                children: <TextSpan>[
                  TextSpan(text: '12345678', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondaryContainer))
                ]
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: RichText(
              text: TextSpan(
                text: 'Status: ', 
                style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSecondaryContainer), 
                children: <TextSpan>[
                  TextSpan(text: 'Delivered', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondaryContainer))
                ]
              ),
            ),
          ),
          trailing: const Icon(Icons.watch_later_rounded, size: 32,),
        ),
      ),
    );
  }
}