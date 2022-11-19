import 'package:flutter/material.dart';
import 'package:workout_task/core/utils/size_mg.dart';

class CustomDropDown<T> extends StatefulWidget {
  final String hintText;
  final List<T> listData;
  final ValueChanged<T?> onChanged;
  final FocusNode focusNode;

  CustomDropDown({
    Key? key,
    required this.hintText,
    required this.listData,
    required this.onChanged,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<P> extends State<CustomDropDown<P>> {
  P? selectedValue;

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Container(
      height: SizeMg.height(64),
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.black45,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<P>(
          value: selectedValue,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(6),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 24,
          ),
          items: widget.listData.map<DropdownMenuItem<P>>((item) {
            return DropdownMenuItem<P>(
              value: item,
              child: Text(
                item.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeMg.text(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: (P? value) {

            if (value == null || value == "Please select workout") {
              return;
            }

            setState(() {
              selectedValue = value;
            });

            widget.onChanged(value);
          },
          isExpanded: true,
          hint: Text(
            widget.hintText,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: SizeMg.text(16),
            fontWeight: FontWeight.w400,
          ),
          focusNode: widget.focusNode,
        ),
      ),
    );
  }
}