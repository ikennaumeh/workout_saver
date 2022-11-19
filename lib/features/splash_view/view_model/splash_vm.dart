import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:workout_task/core/app/app.locator.dart';
import 'package:workout_task/core/app/app.logger.dart';
import 'package:workout_task/core/app/app.router.dart';
import 'package:workout_task/core/services/service_api.dart';

class SplashVM extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _api = locator<ServiceApi>();
  final logger = getLogger("SplashVM");

  Future<void> initDatabase() async {
    try {
      await _api.initDatabase();
      startUpLogic();
    } catch(e) {
      logger.e('Error while initialising local database: ${e.toString()}');
    }
  }

  void _initialize() async {
    _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    return;
  }

  Future<void> startUpLogic() async {
    Duration duration = const Duration(seconds: 4);
    Timer(duration, _initialize);
  }
}