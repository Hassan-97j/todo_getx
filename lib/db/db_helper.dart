import 'package:sqflite/sqflite.dart';
import 'package:todo_getx/modals/tasks.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';

  static Future<void> initDB() async {
    if (db != null) {
      return;
    } try {
      String path = await getDatabasesPath() + 'tasks.db';
      db = await openDatabase(
        path,
        version: version,
        onCreate: (db, version) {
          // ignore: avoid_print
          print('create new one');
          return db.execute(
            "CREATE TABLE $tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)"
          );
        }
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    // ignore: avoid_print
    print('insert function called');
    return await db?.insert(tableName, task!.toJson())??1;
  }

  static Future<List<Map<String,dynamic>>> query() async {
    // ignore: avoid_print
    print('query function called');
    return await db!.query(tableName);
     
  }

  static delete(Task task) async{

    await db!.delete(tableName ,where: 'id=?',whereArgs: [task.id]);

  }

  static update(int id)  async{
    return await db!.rawUpdate(''' 
    UPDATE tasks
    SET isCompleted =? 
    WHERE id =?

    ''', [1,id]);
  }

}