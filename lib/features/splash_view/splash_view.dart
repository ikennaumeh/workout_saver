import 'package:flutter/material.dart';
import 'package:workout_task/core/utils/palette.dart';
import 'package:workout_task/core/utils/size_mg.dart';

import 'view_model/splash_vm.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  late SplashVM _model;

  @override
  void initState() {
    super.initState();
    _model = SplashVM();
    _model.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: Palette.lightBlue,
      body: Center(
        child: Text(
          "Magic Workouts",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: SizeMg.text(30),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

