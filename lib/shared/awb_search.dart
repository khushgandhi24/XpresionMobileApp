import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:xprapp/services/awb_search_model.dart';

class AWBSearch extends StatefulWidget {
  const AWBSearch({super.key, required this.page});

  final String page;

  @override
  State<AWBSearch> createState() => _AWBSearchState();
}

class _AWBSearchState extends State<AWBSearch> {
  final awbController = TextEditingController();

  Future<void> scanBarcode() async {
    String res;

    try {
      res = await FlutterBarcodeScanner.scanBarcode(
          '#385ca9', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      res = ' ';
    }

    if (!mounted) return;

    setState(() {
      if (res != '-1') {
        awbController.text = res;
      }
    });

    submit(awbController.text);
  }

  void submit(String text) {
    Provider.of<SearchModel>(context, listen: false)
        .onSubmit(text, widget.page);
  }

  void reset() {
    Provider.of<SearchModel>(context, listen: false).reset();
    setState(() {
      awbController.clear();
    });
  }

  @override
  void initState() {
    awbController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    awbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: awbController,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
            keyboardType: TextInputType.number,
            cursorColor: Theme.of(context).colorScheme.tertiary,
            decoration: InputDecoration(
              labelText: 'AWB No.',
              hintText: 'Enter AWB No.',
              suffixIcon: IconButton(
                onPressed: () {
                  if (awbController.text.isNotEmpty) {
                    reset();
                  }
                },
                icon: (awbController.text.isEmpty)
                    ? const Icon(Icons.search_rounded)
                    : const Icon(Symbols.close_rounded),
              ),
            ),
            onChanged: (String s) =>
                (widget.page == "scan") ? submit(awbController.text) : null,
            onSubmitted: (String s) => submit(awbController.text),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: scanBarcode,
            icon: const Icon(Symbols.barcode_scanner),
            iconSize: 42,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
