import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_task/core/models/workout.dart';

class WorkoutStore extends ChangeNotifier {
  late Database _db;
  static String tableName = "Workout";

  void init(Database db) {
    _db = db;
  }

  static String get createUserStatement => """
    CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT ,
    weight TEXT ,
    repetition TEXT ,
    sets TEXT ,
    photoUrl TEXT  
  )""";

  Future<void> clear() async {
    await _db.delete(tableName);
  }

  Future<void> insert(WorkOut workOut) async {
    await _db.insert(
      tableName,
      workOut.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> deleteWork(WorkOut workOut) async {
    await _db.delete(
        tableName,
        where: "id = ?",
        whereArgs: [workOut.id],
    );
    notifyListeners();
  }

  Future<void> update(WorkOut workout) async {
    await _db.update(
        tableName,
        workout.toJSON(),
        where: "id = ?",
        whereArgs: [workout.id],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    notifyListeners();
  }



  Future<List<WorkOut?>> fetchWorkouts() async {
    var records = await _db.query(tableName);

    if ((records).isEmpty) {
      return [];
    }
    return records.map((data) => WorkOut.fromJSON(data)).toList();
  }
}
