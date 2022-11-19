import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:workout_task/core/status.dart';
import 'package:workout_task/core/utils/palette.dart';
import 'package:workout_task/core/utils/size_mg.dart';
import 'package:workout_task/features/home/view_model/home_view_model.dart';

import 'widgets/workout_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late HomeViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = HomeViewModel();
  }
  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workout List View",
          style: TextStyle(
            fontSize: SizeMg.text(20),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.fetchWorkout(),
        builder: (_, model, __){

          ///empty state
          if(model.workoutList.isEmpty){
            return Center(child: Text(
              "You haven't done any workout at this \ntime. Tap the add button to track\n a new workout.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeMg.text(17),
                fontWeight: FontWeight.w500,
              ),
            ), );
          }

          ///data state
          return ListView.separated(
            itemCount: model.workoutList.length,
            shrinkWrap: true,
            itemBuilder: (c,i){
              final workout = model.workoutList.elementAt(i);
              return Dismissible(
                key: UniqueKey(),
                  onDismissed: (direction){
                    model.deleteWorkout(workout!);
                  },
                background: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          Spacer(),
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )),
                ),
                  child: GestureDetector(
                    onTap: (){
                      _model.actionRouteAddWorkoutView(workOut: workout, status: Status.update);
                    },
                    child: WorkoutTile(
                      workout: workout,
                    ),
                  ),
              );
            },
            separatorBuilder: (c,i){
              return SizedBox(height: SizeMg.height(15),);
            },
          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.lightBlue,
        onPressed: (){
          _model.actionRouteAddWorkoutView(status: Status.fresh);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}




