import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/models/workout_program.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/core/status.dart';

class AddWorkoutVM extends BaseViewModel{

  final _api = locator<ServiceApi>();
  final _navigationService = locator<NavigationService>();


  List<WorkoutProgram> workoutPrograms = [
    WorkoutProgram(name: "Barbell row", image: "assets/images/barbell_roll.jpg"),
    WorkoutProgram(name: "Bench press", image: "assets/images/bench_press.jpg"),
    WorkoutProgram(name: "Shoulder press", image: "assets/images/shoulder_press.jpg"),
    WorkoutProgram(name: "Dead lift", image: "assets/images/deadlift.jpg"),
    WorkoutProgram(name: "Squats", image: "assets/images/squats.jpg"),
  ];

  Future<void> addToDb(WorkOut workOut, Status status) async {
    if(status == Status.fresh){
      await _api.addToDb(workOut);
      _api.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout));
      goBack();
      return;
    }
    await _api.update(workOut);
    _api.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout));
    goBack();
    return;

  }

  void goBack(){
    _navigationService.back();
  }

}
