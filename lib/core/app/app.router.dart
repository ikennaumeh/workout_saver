// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i8;
import 'package:workout_task/core/models/workout.dart' as _i7;
import 'package:workout_task/core/status.dart' as _i5;
import 'package:workout_task/features/add_workout/add_workout_view.dart' as _i4;
import 'package:workout_task/features/home/home_view.dart' as _i3;
import 'package:workout_task/features/splash_view/splash_view.dart' as _i2;

class Routes {
  static const splashView = '/';

  static const homeView = '/home-view';

  static const addWorkoutView = '/add-workout-view';

  static const all = <String>{
    splashView,
    homeView,
    addWorkoutView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i3.HomeView,
    ),
    _i1.RouteDef(
      Routes.addWorkoutView,
      page: _i4.AddWorkoutView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.HomeView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i3.HomeView(),
        settings: data,
      );
    },
    _i4.AddWorkoutView: (data) {
      final args = data.getArgs<AddWorkoutViewArguments>(
        orElse: () => const AddWorkoutViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i4.AddWorkoutView(
            key: args.key, workOut: args.workOut, status: args.status),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddWorkoutViewArguments {
  const AddWorkoutViewArguments({
    this.key,
    this.workOut,
    this.status = _i5.Status.fresh,
  });

  final _i6.Key? key;

  final _i7.WorkOut? workOut;

  final _i5.Status status;
}

extension NavigatorStateExtension on _i8.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddWorkoutView({
    _i6.Key? key,
    _i7.WorkOut? workOut,
    _i5.Status status = _i5.Status.fresh,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addWorkoutView,
        arguments:
            AddWorkoutViewArguments(key: key, workOut: workOut, status: status),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
