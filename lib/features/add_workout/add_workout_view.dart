import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workout_task/core/models/workout.dart';
import 'package:workout_task/core/models/workout_program.dart';
import 'package:workout_task/core/status.dart';
import 'package:workout_task/core/utils/palette.dart';
import 'package:workout_task/core/utils/size_mg.dart';
import 'package:workout_task/features/add_workout/view_model/add_workout_vm.dart';

import 'widgets/custom_dropdown.dart';

class AddWorkoutView extends StatefulWidget {
  final WorkOut? workOut;
  final Status status;

  const AddWorkoutView({Key? key, this.workOut, this.status = Status.fresh}) : super(key: key);

  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  late TextEditingController _weightsController;
  late TextEditingController _repsController;
  late TextEditingController _setsController;
  late FocusNode _dropdownNode;
  late FocusNode _weightNode;
  late FocusNode _setsNode;
  late FocusNode _repsNode;

  late AddWorkoutVM _model;

  String? workoutType;
  String? image;

  @override
  void initState() {
    super.initState();
    _model = AddWorkoutVM();

    _weightsController = TextEditingController();
    _repsController = TextEditingController();
    _setsController = TextEditingController();

    _dropdownNode = FocusNode();
    _weightNode = FocusNode();
    _setsNode = FocusNode();
    _repsNode = FocusNode();

    prefillInputFields();
  }

  void prefillInputFields() {
    if (widget.status == Status.update) {
      _weightsController.text = widget.workOut?.weight ?? "";
      _repsController.text = widget.workOut?.repetition ?? "";
      _setsController.text = widget.workOut?.sets ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.status == Status.update ? "Edit Your Workout" : "Add your workout",
            style: TextStyle(
              fontSize: SizeMg.text(20),
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: ViewModelBuilder<AddWorkoutVM>.reactive(
            viewModelBuilder: () => AddWorkoutVM(),
            builder: (_, model, __) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeMg.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeMg.height(15),
                    ),
                    Builder(builder: (context) {
                      if (widget.status == Status.update) {
                        return TextFormField(
                          initialValue: widget.workOut?.name ?? '',
                          readOnly: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeMg.text(16),
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                        );
                      }
                      return CustomDropDown<WorkoutProgram>(
                        hintText: "Please select workout",
                        listData: model.workoutPrograms,
                        onChanged: (newValue) {
                          workoutType = newValue?.name ?? "";
                          image = newValue?.image ?? "";
                          _weightNode.requestFocus();
                        },
                        focusNode: _dropdownNode,
                      );
                    }),
                    SizedBox(
                      height: SizeMg.height(15),
                    ),
                    Text(
                      "Weights:",
                      style: TextStyle(
                        fontSize: SizeMg.text(20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: _weightsController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeMg.text(16),
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.black45,
                      focusNode: _weightNode,
                      onFieldSubmitted: (value) {
                        _setsNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        hintText: "Eg. 1kg",
                        hintStyle: TextStyle(
                          fontSize: SizeMg.text(16),
                          fontWeight: FontWeight.w400,
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: SizeMg.height(15),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sets:",
                                style: TextStyle(
                                  fontSize: SizeMg.text(20),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                controller: _setsController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeMg.text(16),
                                  fontWeight: FontWeight.w400,
                                ),
                                cursorColor: Colors.black45,
                                focusNode: _setsNode,
                                onFieldSubmitted: (value) {
                                  _repsNode.requestFocus();
                                },
                                decoration: InputDecoration(
                                  hintText: "Eg. 1",
                                  hintStyle: TextStyle(
                                    fontSize: SizeMg.text(16),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeMg.width(20),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reps:",
                                style: TextStyle(
                                  fontSize: SizeMg.text(20),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                controller: _repsController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeMg.text(16),
                                  fontWeight: FontWeight.w400,
                                ),
                                cursorColor: Colors.black45,
                                focusNode: _repsNode,
                                onFieldSubmitted: (value) {
                                  _repsNode.unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: "Eg. 1",
                                  hintStyle: TextStyle(
                                    fontSize: SizeMg.text(16),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeMg.height(35),
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.lightBlue,
          onPressed: () {
            if (workoutType == null && widget.workOut?.name == null) return;

            WorkOut workOut = WorkOut(
              id:  widget.workOut?.id,
              name: widget.status == Status.fresh ? workoutType : widget.workOut?.name,
              weight: _weightsController.text.trim(),
              sets: _setsController.text.trim(),
              repetition: _repsController.text.trim(),
              photoUrl: widget.status == Status.fresh ? image : widget.workOut?.photoUrl,
            );

            _model.addToDb(workOut, widget.status);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
