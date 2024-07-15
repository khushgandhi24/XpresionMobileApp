import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ShipmentDetails extends StatelessWidget {
  const ShipmentDetails({super.key, required this.awb, required this.date, required this.status, this.watch = false});

  final String awb;
  final String date;
  final String status;
  final bool watch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8,),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(width: 2, color: Theme.of(context).colorScheme.onSurface)
      ),
      height: 300,
      child: Stack(
        children: [
          (watch) ? 
          const Align(alignment: Alignment.bottomRight,
           child: Padding(
             padding: EdgeInsets.only(right: 6),
             child: Icon(Symbols.watch_later, size: 36,),
           ))
          : const SizedBox.shrink(),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('AWB No.',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(awb,
                          style: const TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Booking Date.',
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        Text(date,
                          style: const TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Status',
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        Text(status,
                          style: const TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    )
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Delivery Date',
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        Text('19/5/24',
                          style: TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    ),
                    Column(
                      children: [
                        Text('Delivery Time',
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        Text('16:29',
                          style: TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    ),
                    Column(
                      children: [
                        Text('Receiver Name',
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        Text('Manish',
                          style: TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    )
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