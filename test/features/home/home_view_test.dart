import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/app/app.router.dart';
import 'package:workout_task/core/services/service_api.dart';
import 'package:workout_task/features/home/home_view.dart';
import 'package:workout_task/main.dart';
import '../../helpers/helper_classes.dart';

void main() {
  late MockServiceApi mockServiceApi;
  late MockNavigationService mockNavService;

  setUp((){
    mockServiceApi = MockServiceApi();
    mockNavService = MockNavigationService();
    locator.registerSingleton<ServiceApi>(mockServiceApi);
    locator.registerSingleton<NavigationService>(mockNavService);
  });

  Widget createWidgetUnderTest(){
    return MaterialApp(
      title: 'Magic Workout',
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }

    testWidgets("Text is displayed", (widgetTester) async {

      when(()=> mockServiceApi.initDatabase()).thenAnswer((_) async {});
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(const Key("id-key"),), findsOneWidget);

    });
}