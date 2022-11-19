import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/utils/palette.dart';
import 'core/app/app.router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Workout',
      theme: ThemeData(
          scaffoldBackgroundColor: Palette.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Palette.white,
              elevation: 0
          ),
          fontFamily: GoogleFonts.nunito().fontFamily,
          useMaterial3: true,
          pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android : CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS : ZoomPageTransitionsBuilder(),
              }
          )
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
