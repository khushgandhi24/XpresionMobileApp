import 'package:flutter/material.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.35,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Invoice No.', style: TextStyle(fontSize: 12),),
                  Text('12345678', style: TextStyle(fontSize: 12),),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Invoice Date',style: TextStyle(fontSize: 12),),
                  Text('24/01/2001', style: TextStyle(fontSize: 12),),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Code', style: TextStyle(fontSize: 12),),
                  Text('5401', style: TextStyle(fontSize: 12),),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Actions', style: TextStyle(fontSize: 12),),
                  Text('D / P', style: TextStyle(fontSize: 12),),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Amount', style: TextStyle(fontSize: 12),),
                  Text('1000', style: TextStyle(fontSize: 12),),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Tax', style: TextStyle(fontSize: 12),),
                  Text('100', style: TextStyle(fontSize: 12),),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Surcharge', style: TextStyle(fontSize: 12),),
                  Text('20', style: TextStyle(fontSize: 12),),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.center,
                children: [
                  Text('Total Amount', style: TextStyle(fontSize: 12),),
                  Text('1120', style: TextStyle(fontSize: 12),),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}