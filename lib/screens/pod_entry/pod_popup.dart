import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:xprapp/theme.dart';

class PODPopup extends StatefulWidget {
  const PODPopup({super.key});

  @override
  State<PODPopup> createState() => _PODPopupState();
}

class _PODPopupState extends State<PODPopup> {
  final signController = SignatureController(
    penStrokeWidth: 4,
    penColor: lightColorScheme.inverseSurface,
  );

  Future<Uint8List?> exportSign() async {
    final expController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        points: signController.points);

    final signImage = await expController.toPngBytes();
    expController.dispose();
    return signImage;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 32,
                )),
            const Text(
              'Signature',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              width: 44,
            ),
          ],
        ),
        content: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: lightColorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          width: 2, color: lightColorScheme.outlineVariant)),
                  child: Signature(
                    controller: signController,
                    backgroundColor: Colors.transparent,
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () async {
                          if (signController.isNotEmpty) {
                            final sign = await exportSign();
                            Directory? externalStorageDirectory =
                                await getExternalStorageDirectory();
                            File finalFile = File(path.join(
                                externalStorageDirectory!.path,
                                path.basename(
                                    '${DateTime.now().toIso8601String()}.jpg')));
                            await finalFile.writeAsBytes(sign!);
                            debugPrint(finalFile.path);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Signature Saved'),
                              showCloseIcon: true,
                              padding: const EdgeInsets.all(24),
                              duration: const Duration(milliseconds: 1500),
                              backgroundColor:
                                  Theme.of(context).colorScheme.inverseSurface,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24))),
                            ));
                          }
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8))),
                        child: const Text('Save')),
                    TextButton(
                        onPressed: () {
                          signController.clear();
                        },
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8))),
                        child: const Text('Reset'))
                  ],
                ),
              ],
            )));
  }
}
