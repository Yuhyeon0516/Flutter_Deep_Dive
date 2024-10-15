import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: DimenssionHelper.size35,
      width: DimenssionHelper.size130,
      decoration: BoxDecoration(
        color: ColorHelper.primaryColor,
        borderRadius: BorderRadius.circular(DimenssionHelper.size50),
      ),
      child: Text(
        'Done',
        style: TextStyle(
          color: ColorHelper.whiteColor,
          fontWeight: FontHelper.w400,
          fontSize: FontHelper.font_16,
        ),
      ),
    );
  }
}
