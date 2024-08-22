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
  int _index = 0;
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (!widget.mode)
                          ? const Expanded(
                              child: SizedBox(
                                width: 10,
                              ),
                            )
                          : const SizedBox.shrink(),
                      const Text(
                        "Add Entry",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      // const SizedBox(
                      //   width: 20,
                      // ),
                      (!widget.mode)
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
              : const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("Edit Entry",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
          //   child: Column(
          //     children: FormField.values.map((FormField field) {
          //       return EntryTile(title: field.name, route: field.toString());
          //     }).toList(),
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
              child: Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: <Widget>[
                      // TextButton(
                      //   onPressed: details.onStepContinue,
                      //   child: Text('Next'),
                      // ),
                      // TextButton(
                      //   onPressed: details.onStepCancel,
                      //   child: Text('Back'),
                      // ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text('Save'),
                      // ),
                    ],
                  );
                },
                stepIconBuilder: (stepIndex, stepState) {
                  return (stepState != StepState.complete)
                      ? Icon(
                          Icons.edit,
                          size: 12,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Icon(
                          Icons.check,
                          size: 12,
                          color: Theme.of(context).colorScheme.onTertiary,
                        );
                },
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index >= 0 && _index < 6) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: FormField.values.map((FormField field) {
                  return Step(
                      stepStyle: StepStyle(
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer)),
                      state: _index > field.index
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: _index >= field.index,
                      title: Text(field.name),
                      content: EntryTile(
                        title: field.name,
                        route: field.toString(),
                        index: field.index,
                      ));
                }).toList(),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
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
