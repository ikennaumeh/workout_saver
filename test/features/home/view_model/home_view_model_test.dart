import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/features/home/view_model/home_view_model.dart';
import '../../../helpers/helper_classes.dart';


void main(){

  late MockNavigationService mockNavService;
  late MockServiceApi mockServiceApi;
  late MockStreamSubscription mockStreamService;
  late HomeViewModel sut; ///sut means system under tests

  setUp(() {
    mockStreamService = MockStreamSubscription();
    sut = HomeViewModel(mockStreamService);
  });

  group("HomeViewModelTest", () {
    mockServiceApi = MockServiceApi();
    mockNavService = MockNavigationService();
    locator.registerSingleton<ServiceApi>(mockServiceApi);
    locator.registerSingleton<NavigationService>(mockNavService);

    final workoutsFromService = [
      WorkOut(id: 1, name: "Workout 1", weight: "1", sets: "1", repetition: "1"),
      WorkOut(id: 2, name: "Workout 2", weight: "2", sets: "2", repetition: "2"),
      WorkOut(id: 3, name: "Workout 3", weight: "3", sets: "3", repetition: "3"),

    ];

    final workout = WorkOut(id: 1, name: "Workout 1", weight: "1", sets: "1", repetition: "1");

    final serviceEvent = ServiceEventStream<ServiceEvent>();


    void serviceApiReturns3Workouts(){
      when(() => mockServiceApi.getWorkouts()).thenAnswer((_) async => workoutsFromService);
    }

    test("initials values are correct", () {
      expect(sut.workoutList, []);
    });

    group("fetchWorkouts", () {

      test("fetch workouts using service api", () async {
        serviceApiReturns3Workouts();
        await sut.fetchWorkout();
        verify(() => mockServiceApi.getWorkouts()).called(1);

      });

      test("sets workoutList to the ones from the service", () async {
        serviceApiReturns3Workouts();
        await sut.fetchWorkout();
        expect(sut.workoutList, workoutsFromService);

      });

    });

    group("deleteWorkout", () {
      test("delete workouts from db in service api ", () async {
         when(() => mockServiceApi.deleteWorkout(workout)).thenAnswer((_) async {});
         when(() => mockServiceApi.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout))).thenAnswer((_) => serviceEvent);
         await sut.deleteWorkout(workout);
         verify(() => mockServiceApi.deleteWorkout(workout)).called(1);
      });
    });

  });



}