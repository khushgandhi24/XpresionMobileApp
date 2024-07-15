// import 'package:android_path_provider/android_path_provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// late String localPath;

// Future<void> prepareSaveDir() async {
//   localPath = (await findLocalPath())!;
//   final savedDir = Directory(localPath);
//   bool hasExisted = await savedDir.exists();
//   if (!hasExisted) {
//     savedDir.create();
//   }
//   return;
// }

// Future<String?> findLocalPath() async {
//   String? externalStorageDirPath;
//   if (Platform.isAndroid) {
//     try {
//       externalStorageDirPath = await AndroidPathProvider.documentsPath;
//     } catch (e) {
//       final directory = await getExternalStorageDirectory();
//       externalStorageDirPath = directory?.path;
//     }
//   } else if (Platform.isIOS) {
//     externalStorageDirPath =
//         (await getApplicationDocumentsDirectory()).absolute.path;
//   }
//   return externalStorageDirPath;
// }
