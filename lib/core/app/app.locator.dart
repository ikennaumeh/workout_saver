// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';

import '../data/db.dart';
import '../data/workout_store.dart';
import '../services/service_api.dart';
import '../services/stream_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => WorkoutStore());
  locator.registerLazySingleton(() => AppDB());
  locator.registerLazySingleton(() => ServiceApi());
  locator.registerLazySingleton(() => ServiceEventStream<ServiceEvent>());
}
