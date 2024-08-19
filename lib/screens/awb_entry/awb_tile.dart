import 'package:flutter/material.dart';

class AWBTile extends StatelessWidget {
  const AWBTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text('18/05/24',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12)),
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(
                        "AWB No.",
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Text("3000012051"),
                    ),
                    ListTile(
                      title: Text("Product", style: TextStyle(fontSize: 12)),
                      subtitle: Text("SPX"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title:
                          Text("Destination", style: TextStyle(fontSize: 12)),
                      subtitle: Text("Delhi"),
                    ),
                    ListTile(
                      title: Text("Pieces", style: TextStyle(fontSize: 12)),
                      subtitle: Text("2"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
