import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';

Future<void> createDb(String filename) async {
  final database = await openDatabase(filename);
  await database.execute('DROP TABLE IF EXISTS qr_codes');
  await database.execute(
      'CREATE TABLE qr_codes (id INTEGER PRIMARY KEY AUTOINCREMENT, qrCode BLOB, matchNumber TEXT, teamNumber TEXT)');
  await database.close();
}

Future<void> insertQRCode(
    Uint8List qrCodeBytes, String matchNumber, String teamNumber) async {
  final database = await openDatabase('qr_codes.db');
  await database.insert('qr_codes', {
    'qrCode': qrCodeBytes,
    'matchNumber': matchNumber,
    'teamNumber': teamNumber,
  });
  await database.close();
}

Future<List<Map<String, dynamic>>> retrieveQRCodes(
    {String? matchNumber, String? teamNumber}) async {
  final database = await openDatabase('qr_codes.db');
  String whereClause = '';
  List<String> whereArgs = [];

  if (matchNumber != null && matchNumber.isNotEmpty) {
    whereClause = 'matchNumber = ?';
    whereArgs.add(matchNumber);
  }

  if (teamNumber != null && teamNumber.isNotEmpty) {
    if (whereClause.isNotEmpty) {
      whereClause += ' AND ';
    }
    whereClause += 'teamNumber = ?';
    whereArgs.add(teamNumber);
  }

  final List<Map<String, dynamic>> qrCodes = await database.query(
    'qr_codes',
    where: whereClause.isNotEmpty ? whereClause : null,
    whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
  );

  await database.close();
  return qrCodes;
}

Future<void> main() async {
  String filenameDb = 'qr_codes.db';
  await createDb(filenameDb);
}
