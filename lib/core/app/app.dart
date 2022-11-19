import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/data/db.dart';
import 'package:workout_task/core/data/workout_store.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/features/add_workout/add_workout_view.dart';
import 'package:workout_task/features/home/home_view.dart';
import 'package:workout_task/features/splash_view/splash_view.dart';


/// use build runner code below
/// flutter pub run build_runner build --delete-conflicting-outputs

@StackedApp(
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: WorkoutStore),
    LazySingleton(classType: AppDB),
    LazySingleton(classType: ServiceApi),
    LazySingleton(classType: ServiceEventStream<ServiceEvent>)
  ],
  routes: [
    AdaptiveRoute(page: SplashView, initial: true),
    AdaptiveRoute(page: HomeView),
    AdaptiveRoute(page: AddWorkoutView),
  ],
  logger: StackedLogger(),
)
class AppSetup{}