import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/app/app.router.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/core/status.dart';

class HomeViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _api = locator<ServiceApi>();
  late StreamSubscription<ServiceEvent>? subscription;

  HomeViewModel([StreamSubscription<ServiceEvent>? subService]){
     subscription = subService ?? _api.serviceEventStream.listen(serviceEventListener);
  }

  void serviceEventListener(ServiceEvent event){
    if(event.type == ServiceEventType.workout){
      fetchWorkout();
    }
  }

  List<WorkOut?> workoutList = [];

  Future<void> fetchWorkout() async {
    workoutList = await _api.getWorkouts();
    notifyListeners();
  }

  Future<void> deleteWorkout(WorkOut workOut) async {
    await _api.deleteWorkout(workOut);
    _api.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout));
  }

  void actionRouteAddWorkoutView({WorkOut? workOut, required Status status}){
    _navigationService.navigateToAddWorkoutView(workOut: workOut, status: status);
  }

}