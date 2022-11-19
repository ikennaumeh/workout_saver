import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/data/db.dart';
import 'package:workout_task/core/models/workout.dart';

import 'stream_service.dart';

class ServiceApi{
  late ServiceEventStream serviceEventStream;
  final _db = locator<AppDB>();

  ServiceApi(){
    serviceEventStream = locator.get<ServiceEventStream>();
  }

  Future<void> initDatabase() async {
    await _db.init();
  }

  Future<List<WorkOut?>> getWorkouts() async {
    var results = await _db.workoutStore.fetchWorkouts();
    return results;
  }

  Future<void> addToDb(WorkOut workOut) async {
    await _db.workoutStore.insert(workOut);
  }

  Future<void> deleteWorkout(WorkOut workOut) async {
    await _db.workoutStore.deleteWork(workOut);
  }

  Future<void> update(WorkOut workOut) async{
    await _db.workoutStore.update(workOut);
  }

}