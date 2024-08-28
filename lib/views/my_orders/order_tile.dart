import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.275,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 2),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('Date'), Text('Pickup From'), Text('Amount')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Pickup No.'),
              const Text('Delivery At'),
              (active)
                  ? TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.transparent),
                          foregroundColor: WidgetStatePropertyAll(Colors.red),
                          elevation: WidgetStatePropertyAll(0),
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0))),
                      onPressed: () {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ))
                  : const Text("AWB No."),
            ],
          )
        ],
      ),
    );
  }
}
