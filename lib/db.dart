import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:image/image.dart' as img;

const String PATH_IMAGES = 'Images/'; // change later

Future<void> createDb(String filename) async {
  final database = await openDatabase(filename);
  await database.execute('DROP TABLE IF EXISTS qr_codes');
  await database.execute(
      'CREATE TABLE qr_codes (id INTEGER, qrCode BLOB, matchNumber TEXT, teamNumber TEXT)');
  await database.close();
}

Future<void> main() async {
  final List<FileSystemEntity> files = Directory(PATH_IMAGES)
      .listSync()
      .where((file) => file.path.endsWith('.jpg'))
      .toList();

  String filenameDb = 'qr_codes.db';
  await createDb(filenameDb);

  final database = await openDatabase(filenameDb);
  final batch = database.batch();

  for (var i = 0; i < files.length; i++) {
    final file = files[i];
    final imageBytes = await File(file.path).readAsBytes();

    final img.Image? imgNp = img.decodeImage(imageBytes);
    if (imgNp == null) continue;

    int matchNumber = imgNp.width;
    int teamNumber = imgNp.height;

    String filename = p.relative(file.path, from: PATH_IMAGES);
    int objId = int.parse(p.basenameWithoutExtension(filename));

    batch.insert('qr_codes', {
      'id': objId,
      'qrCode': imageBytes,
      'matchNumber': matchNumber.toString(),
      'teamNumber': teamNumber.toString(),
    });
  }

  await batch.commit(noResult: true);
  await database.close();
}
