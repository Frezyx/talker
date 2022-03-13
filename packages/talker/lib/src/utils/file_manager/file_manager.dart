// import 'dart:io';

// class FileManager {
//   static const _folderPath = 'talker/';

//   late String _name;
//   //TODO: lazy getter creation
//   Future<File> get file async {
//     return _file ?? (await createLogFile());
//   }

//   File? _file;

//   Future<File> createLogFile() async {
//     _name = 'talker_logs_${DateTime.now()}';
//     return _file = await File('$_folderPath$_name').create(recursive: true);
//   }

//   Future<void> writeToLogFile(String str) async {
//     final writed = await (await file).readAsString();
//     await (await file).writeAsString(writed + str);
//   }
// }
