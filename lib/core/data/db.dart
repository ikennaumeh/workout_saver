

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/data/workout_store.dart';

String dbName = "app_db";

class AppDB{
  late String databasePath;
  late Database _db;
  late WorkoutStore workoutStore;

  AppDB(){
    workoutStore = locator.get<WorkoutStore>();
  }

  Future<void> init() async {
    databasePath = await getDatabasesPath();
    _db = await openDatabase(
      "$databasePath/$dbName",
      version: 1,
      onCreate: onCreate,
    );

    workoutStore.init(_db);

  }

  @visibleForTesting
  void onCreate(Database db, int version) async{
    await db.execute(WorkoutStore.createUserStatement);
  }

  Future<void> clear() async {
    await workoutStore.clear();
  }
}