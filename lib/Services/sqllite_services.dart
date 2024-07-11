import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteServiceProvider {
  static late Database _db;

  static Future<void> initializeDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'TODO.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE ALARAM (id INTEGER PRIMARY KEY AUTOINCREMENT, DateTime TEXT)',
        );
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getAllDetails() async {
    final _values = await _db.rawQuery('SELECT * FROM ALARAM');
    return _values;
  }

  Future<void> addTasks({required List<DateTime> alaram_list}) async {
    try {
      for (var dateTime in alaram_list) {
        await _db.insert(
          'ALARAM',
          {'DateTime': dateTime.toIso8601String()},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteTask(int id) async {
    try {
      await _db.delete(
        'ALARAM',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }
}
