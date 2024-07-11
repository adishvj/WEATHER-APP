import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteServiceProvider {
  static late Database _db;

  static Future<void> initializeDatabase() async {
    print('hhhhhhhhhhhhhhhhhhhhhh');
    _db = await openDatabase(
      join(await getDatabasesPath(),
          'TODO.db'), // Ensure the database path is correctly set
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
    print("All records:");
    print(_values);
    return _values;
  }

  Future<void> addTasks({required List alaram_list}) async {
    try {
      for (int index = 0; index < alaram_list.length; index++) {
        print("Inserting alarm at index: $index");
        int id = await _db.insert(
          'ALARAM',
          {'DateTime': alaram_list[index].toString()},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        print("Inserted record ID: $id");
      }
    } catch (e) {
      print(e);
    }
    getAllDetails();
  }

  // Function to delete a task by its id
  static Future<void> deleteTask(int id) async {
    try {
      int count = await _db.delete(
        'ALARAM',
        where: 'id = ?',
        whereArgs: [id],
      );
      print("Deleted $count record(s) with id: $id");
    } catch (e) {
      print(e);
    }
    getAllDetails();
  }
}
