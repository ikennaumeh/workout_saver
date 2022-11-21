import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/features/add_workout/add_workout_view.dart';

import '../../helpers/helper_classes.dart';
import '../../helpers/helper_variables.dart';

void main(){

  late MockNavigationService mockNavService;
  late MockServiceApi mockServiceApi;


  group("Add workout view test", () {
    mockServiceApi = MockServiceApi();
    mockNavService = MockNavigationService();
    locator.registerSingleton<NavigationService>(mockNavService);
    locator.registerSingleton<ServiceApi>(mockServiceApi);

    void serviceApiReturns3WorkoutsAndServiceStream(){
      when(() => mockServiceApi.getWorkouts()).thenAnswer((_) async => workoutsFromService);
      when(() => mockServiceApi.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout))).thenAnswer((_) => serviceEvent);

    }

    testWidgets("Test for main widgets on add workout screen", (widgetTester) async {

      serviceApiReturns3WorkoutsAndServiceStream();

      await widgetTester.pumpWidget(const MaterialApp(home: AddWorkoutView(),));

      await widgetTester.pump();

      expect(find.text("Add your workout"), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);

    });
  });

}