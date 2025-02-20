import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'qr_image.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'qr_codes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE qr_codes(id INTEGER PRIMARY KEY AUTOINCREMENT, matchNumber TEXT, teamNumber TEXT, qrCode QRImage)',
        );
      },
    );
  }

  Future<void> insertQRCode(String matchNumber, String teamNumber,
      Map<String, QRImage> qrCode) async {
    final db = await database;
    await db.insert('qr_codes', qrCode);
  }

  Future<List<Map<String, dynamic>>> searchQRCode(
      String searchType, String searchText) async {
    final db = await database;
    return await db.query(
      'qr_codes',
      where: '$searchType = ?',
      whereArgs: [searchText],
    );
  }
}
