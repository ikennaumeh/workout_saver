import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_task/core/app/app.router.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/core/services/stream_service.dart';
import 'package:workout_task/features/home/home_view.dart';
import '../../helpers/helper_classes.dart';
import 'package:workout_task/core/app/app.locator.dart';
import '../../helpers/helper_variables.dart';

void main(){

  late MockServiceApi mockServiceApi;
  late MockNavigationService mockNavService;



  Widget newWidget(){
    return MaterialApp(
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }

  group("splash and home view test", () {

    mockServiceApi = MockServiceApi();
    mockNavService = MockNavigationService();
    locator.registerSingleton<ServiceApi>(mockServiceApi);
    locator.registerSingleton<NavigationService>(mockNavService);

    void serviceApiReturns3WorkoutsAndServiceStream(){
      when(() => mockServiceApi.getWorkouts()).thenAnswer((_) async => workoutsFromService);
      when(() => mockServiceApi.serviceEventStream.add(ServiceEvent(type: ServiceEventType.workout))).thenAnswer((_) => serviceEvent);

    }

    testWidgets("splash view test is correct", (widgetTester) async {
      when(() => mockServiceApi.initDatabase()).thenAnswer((_) async => {});

      await widgetTester.pumpWidget(newWidget()); ///pump the widget

      await widgetTester.pump(const Duration(seconds: 4)); ///wait for 4 seconds cuz of the splashscreen

      expect(find.text("Magic Workout"), findsOneWidget); ///test passes

    });



    testWidgets("home view details are correct", (widgetTester) async {
      serviceApiReturns3WorkoutsAndServiceStream();

      await widgetTester.pumpWidget(const MaterialApp(home: HomeView()));
      expect(find.text("Workout List View"), findsOneWidget);
      expect(find.byKey(const Key("id-key")), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);


    });

    testWidgets("workouts are displayed", (widgetTester) async {

      serviceApiReturns3WorkoutsAndServiceStream();

      await widgetTester.pumpWidget(const MaterialApp(home: HomeView()));

      await widgetTester.pump();

      for(final workout in workoutsFromService){
        expect(find.text("${workout.name}"), findsOneWidget);
      }

    });
  });


}