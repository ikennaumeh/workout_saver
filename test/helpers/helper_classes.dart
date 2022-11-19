import 'dart:async';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';

class MockServiceApi extends Mock implements ServiceApi{}
class MockNavigationService extends Mock implements NavigationService{}
class MockStreamSubscription extends Mock implements StreamSubscription<ServiceEvent>{}