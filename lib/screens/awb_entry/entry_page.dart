import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:xprapp/screens/awb_entry/entry_tile.dart';

enum FormField {
  entry("Entry Details"),
  shipper("Shipper Details"),
  consignee("Consignee Details"),
  proforma("Proforma Details"),
  weight("Weight & Dimensions"),
  kyc("KYC Details"),
  receipt("Receipt Entry");

  const FormField(this.name);

  final String name;
}

class EntryPage extends StatefulWidget {
  const EntryPage({super.key, required this.mode});

  final bool mode;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logos/Xpr_Color.png',
          width: 140,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (widget.mode)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (widget.mode)
                          ? const Expanded(
                              child: SizedBox(
                                width: 10,
                              ),
                            )
                          : const SizedBox.shrink(),
                      const Text(
                        "Add Entry",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      // const SizedBox(
                      //   width: 20,
                      // ),
                      (widget.mode)
                          ? Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Icon(Symbols.print)),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              : const Text("Edit Entry",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              children: FormField.values.map((FormField field) {
                return EntryTile(title: field.name, route: field.toString());
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.primary),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 14, horizontal: 28))),
                child: const Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    side: WidgetStatePropertyAll<BorderSide>(BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 4)),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 14, horizontal: 28))),
                child: Text(
                  "Reset",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w600),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
