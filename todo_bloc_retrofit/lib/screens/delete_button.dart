import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: DimenssionHelper.size35,
      width: DimenssionHelper.size80,
      decoration: BoxDecoration(
        color: ColorHelper.redColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(DimenssionHelper.size50),
      ),
      child: Icon(
        Icons.delete_outline,
        color: ColorHelper.redColor,
      ),
    );
  }
}
