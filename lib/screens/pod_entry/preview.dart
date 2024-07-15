import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xprapp/theme.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CamPopup extends StatefulWidget {
  const CamPopup({super.key});

  @override
  State<CamPopup> createState() => _CamPopupState();
}

class _CamPopupState extends State<CamPopup> {

  File? galleryFile;
  final picker = ImagePicker();
  
  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
 
  Future getImage(ImageSource img,) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Image not selected')));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: lightColorScheme.surface,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back_rounded, size: 32,)),
                  const Text('Select Image', style: TextStyle(fontSize: 18),),
                  const SizedBox(width: 44,),
                ],
              ),
              const SizedBox(height: 32,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width *0.7,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: galleryFile == null
                  ? Center(child: Text('No Image Selected', style: TextStyle(fontSize: 18, color: lightColorScheme.tertiary,),))
                  : Center(child: Image.file(galleryFile!)),
                  ),
                  const SizedBox(height: 64,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () {
                          setState(() {
                            _showPicker(context: context);
                          });
                      }, icon: Icon(Symbols.camera_alt_rounded, size: 42, fill: 1, color: lightColorScheme.primary,)),
                      const SizedBox(width: 48,),
                      IconButton(onPressed: () async {
                          Directory? externalStorageDirectory = await getExternalStorageDirectory();
                          File finalFile = File(path.join(externalStorageDirectory!.path, path.basename(galleryFile!.path)));
                          await finalFile.writeAsBytes(await galleryFile!.readAsBytes());
                          debugPrint(galleryFile!.path);
                          debugPrint(finalFile.path);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text('Image Saved'),
                            showCloseIcon: true,
                            padding: const EdgeInsets.all(24),
                            duration: const Duration(milliseconds: 1500),
                            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),)
                          );
                          Navigator.of(context).pop();
                      }, icon: const Icon(Symbols.check_rounded, size: 42, color: Colors.green,)),
                      const SizedBox(width: 48,),
                      IconButton(onPressed: () {
                          setState(() {
                            galleryFile = null;
                          });
                      }, icon: Icon(Symbols.clear_rounded, size: 42, color: lightColorScheme.error,))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}