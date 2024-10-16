import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';
import 'package:todo_bloc_retrofit/models/get_all_todo_model.dart';

class DoneButton extends StatelessWidget {
  final Items items;
  const DoneButton({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (items.isCompleted == false) {
        } else {}
      },
      child: Container(
        alignment: Alignment.center,
        height: DimenssionHelper.size35,
        width: DimenssionHelper.size130,
        decoration: BoxDecoration(
          color: ColorHelper.primaryColor,
          borderRadius: BorderRadius.circular(DimenssionHelper.size50),
        ),
        child: Text(
          items.isCompleted! ? 'Done' : 'Mark as Done',
          style: TextStyle(
            color: ColorHelper.whiteColor,
            fontWeight: FontHelper.w400,
            fontSize: FontHelper.font_16,
          ),
        ),
      ),
    );
  }
}
