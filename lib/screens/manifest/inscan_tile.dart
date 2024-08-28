import 'package:flutter/material.dart';

class InscanTile extends StatelessWidget {
  const InscanTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 2),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("Date"), Text("Origin")],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("Manifest No."), Text("Destination")],
          ),
        ],
      ),
    );
  }
}
