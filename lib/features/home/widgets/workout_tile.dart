import 'package:flutter/material.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/utils/palette.dart';
import 'package:workout_task/core/utils/size_mg.dart';

class WorkoutTile extends StatelessWidget {
  final WorkOut? workout;
  const WorkoutTile({
    Key? key,
    required this.workout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: SizeMg.width(20)),
      padding: EdgeInsets.symmetric(horizontal: SizeMg.width(15)),
      height: SizeMg.height(100),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent.shade100,
          borderRadius: BorderRadius.circular(SizeMg.radius(10)),
          boxShadow: const [
            BoxShadow(
                color: Colors.white24,
                offset: Offset(0,2),
                blurRadius: 8
            ),
          ]
      ),
      child: Row(
        children: [
          Builder(
              builder: (context){
                if(workout?.photoUrl == null || "${workout?.photoUrl}".isEmpty){
                  return const Icon(Icons.sports_basketball, size: 50,);
                }
                return Container(
                  width: SizeMg.width(60),
                  height: SizeMg.height(80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeMg.radius(5)),
                    image: DecorationImage(
                      image: AssetImage("${workout?.photoUrl}",),
                      fit: BoxFit.fill
                    )
                  ),
                );
              }
          ),
          SizedBox(width: SizeMg.width(10),),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout?.name ?? "Not set",
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Weights: ",
                    style: TextStyle(
                      fontSize: SizeMg.text(15),
                      fontWeight: FontWeight.w500,
                      color: Palette.black,
                    ),
                    children: [
                      TextSpan(
                        text: "${workout?.weight ?? 0} kg",
                        style: TextStyle(
                          fontSize: SizeMg.text(14),
                          fontWeight: FontWeight.w400,
                          color: Palette.black,
                        ), ),
                    ]
                ),
              ),
            ],
          ),
          SizedBox(width: SizeMg.width(10),),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeMg.height(6),),
              RichText(
                text: TextSpan(
                    text: "Sets: ",
                    style: TextStyle(
                      fontSize: SizeMg.text(17),
                      fontWeight: FontWeight.w500,
                      color: Palette.black,
                    ),
                    children: [
                      TextSpan(
                        text: workout?.sets ?? "0",
                        style: TextStyle(
                          fontSize: SizeMg.text(14),
                          fontWeight: FontWeight.w400,
                          color: Palette.black,
                        ), ),
                    ]
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Repetitions: ",
                    style: TextStyle(
                      fontSize: SizeMg.text(15),
                      fontWeight: FontWeight.w500,
                      color: Palette.black,
                    ),
                    children: [
                      TextSpan(
                        text: workout?.repetition ?? "0",
                        style: TextStyle(
                          fontSize: SizeMg.text(14),
                          fontWeight: FontWeight.w400,
                          color: Palette.black,
                        ), ),
                    ]
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}