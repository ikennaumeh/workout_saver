import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/models/workout_program.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/core/status.dart';
import 'package:workout_task/features/add_workout/view_model/add_workout_vm.dart';

import '../../../helpers/helper_classes.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  late MockNavigationService mockNavService;
  late MockServiceApi mockServiceApi;
  late AddWorkoutVM sut; ///sut means system under tests

  setUp((){
    sut = AddWorkoutVM();
  });

  group("AddWorkoutViewModelTest", () {
    mockNavService = MockNavigationService();
    mockServiceApi = MockServiceApi();
    locator.registerSingleton<ServiceApi>(mockServiceApi);
    locator.registerSingleton<NavigationService>(mockNavService);

    final List<WorkoutProgram> workoutPrograms = [
      WorkoutProgram(name: "Barbell row", image: "assets/images/barbell_roll.jpg"),
      WorkoutProgram(name: "Bench press", image: "assets/images/bench_press.jpg"),
      WorkoutProgram(name: "Shoulder press", image: "assets/images/shoulder_press.jpg"),
      WorkoutProgram(name: "Dead lift", image: "assets/images/deadlift.jpg"),
      WorkoutProgram(name: "Squats", image: "assets/images/squats.jpg"),
    ];

    final workout = WorkOut(id: 1, name: "Workout 1", weight: "1", sets: "1", repetition: "1");

    final serviceEvent = ServiceEventStream<ServiceEvent>();



    test("workout list are prefilled with list of workouts", () {
      expect(sut.workoutPrograms, workoutPrograms);
    });

    group("add to database", () {
      test("adds to db in service api", () async {
        when(() => mockServiceApi.addToDb(workout)).thenAnswer((_) async => {});
        when(() => mockServiceApi.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout))).thenAnswer((_) => serviceEvent);
        when(() => mockNavService.back()).thenAnswer((_) => true);
         await sut.addToDb(workout, Status.fresh);
         verify(() => mockServiceApi.addToDb(workout)).called(1);
      });
    });
  });

}