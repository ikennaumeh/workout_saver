import 'package:mocktail/mocktail.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/services/stream_service.dart';

final workoutsFromService = [
  WorkOut(id: 1, name: "Workout 1", weight: "1", sets: "1", repetition: "1"),
  WorkOut(id: 2, name: "Workout 2", weight: "2", sets: "2", repetition: "2"),
  WorkOut(id: 3, name: "Workout 3", weight: "3", sets: "3", repetition: "3"),

];
final serviceEvent = ServiceEventStream<ServiceEvent>();

final workout = WorkOut(id: 1, name: "Workout 1", weight: "1", sets: "1", repetition: "1");