import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/screens/awb_entry/forms/consignee_details.dart';
import 'package:xprapp/screens/awb_entry/forms/entry_details.dart';
import 'package:xprapp/screens/awb_entry/forms/kyc_details.dart';
import 'package:xprapp/screens/awb_entry/forms/proforma_details.dart';
import 'package:xprapp/screens/awb_entry/forms/receipt_entry.dart';
import 'package:xprapp/screens/awb_entry/forms/shipper_details.dart';
import 'package:xprapp/screens/awb_entry/forms/weight_dimensions.dart';

class EntryTile extends StatefulWidget {
  const EntryTile(
      {super.key,
      required this.title,
      required this.route,
      required this.index});

  final String title;
  final String route;
  final int index;

  @override
  State<EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // DateTime? _selectedDate;
  // TimeOfDay? selectedTime;

  // void _pickDate() async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null && pickedDate != _selectedDate) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 4)),
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        onTap: () {
          // debugPrint(widget.route);
          // Navigator.pushNamed(context, widget.route);
          showBottomSheet(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              context: context,
              enableDrag: false,
              shape: ContinuousRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 2)),
              builder: (BuildContext context) {
                return PopScope(
                  canPop: false,
                  child: SizedBox.expand(
                    child: switch (widget.route) {
                      "FormField.entry" => const EntryDetails(),
                      "FormField.shipper" => const ShipperDetails(),
                      "FormField.consignee" => const ConsigneeDetails(),
                      "FormField.proforma" => const ProformaDetails(),
                      "FormField.weight" => const WeightDimensions(),
                      "FormField.kyc" => const KycDetails(),
                      "FormField.receipt" => const ReceiptEntry(),
                      _ => const EntryDetails(),
                    },
                  ),
                );
              });
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
