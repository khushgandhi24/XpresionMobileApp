import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/shared/alert.dart';
import 'package:xprapp/shared/styled_text.dart';
import 'package:xprapp/theme.dart';

class DeliveryDetailTile extends StatelessWidget {
  const DeliveryDetailTile({super.key, required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 250,
        decoration: BoxDecoration(
            color: lightColorScheme.surface,
            border: Border.all(color: lightColorScheme.outline),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledText('Pickup /AWB No.'),
                    StyledText('0123456789')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [StyledText('Date /Time'), StyledText('12/12/12')],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledText('Consignee'),
                    StyledText('Manish Mahajan')
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const XAlert(
                                  body:
                                      'Block-A, A1 Co-operative Housing Society, 7, A 1, Apartment, Shivaji Rd, Dahanukar Wadi, Kandivali West, Mumbai, Maharashtra 400067',
                                );
                              });
                        },
                        style: ButtonStyle(
                          padding:
                              const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                                  EdgeInsets.zero),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          foregroundColor:
                              WidgetStatePropertyAll(lightColorScheme.primary),
                          shape: WidgetStatePropertyAll(LinearBorder.bottom(
                              side: BorderSide(
                                  color: lightColorScheme.onSurface,
                                  width: 2))),
                          elevation: const WidgetStatePropertyAll(0),
                        ),
                        child: const Text(
                          'View Address',
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
                mode != 'All'
                    ? const Icon(Symbols.call_rounded,
                        color: Colors.lightGreen, size: 36, fill: 1)
                    : const Column(
                        children: [
                          StyledText('Status'),
                          StyledText('Delivered'),
                        ],
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
