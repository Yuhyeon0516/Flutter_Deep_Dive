import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';
import 'package:todo_bloc_retrofit/screens/delete_button.dart';
import 'package:todo_bloc_retrofit/screens/done_button.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: DimenssionHelper.size12,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: DimenssionHelper.size8,
            vertical: DimenssionHelper.size8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorHelper.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(
              DimenssionHelper.size8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Title',
                      style: TextStyle(
                        color: ColorHelper.blackColor,
                        fontWeight: FontHelper.w500,
                        fontSize: FontHelper.font_20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const DeleteButton(),
                ],
              ),
              Text(
                'Description',
                style: TextStyle(
                  color: ColorHelper.blackColor,
                  fontWeight: FontHelper.w400,
                  fontSize: FontHelper.font_16,
                ),
              ),
              const SizedBox(
                height: DimenssionHelper.size12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DoneButton(),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenssionHelper.size16,
                      vertical: DimenssionHelper.size8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorHelper.primaryColor,
                      ),
                      borderRadius:
                          BorderRadius.circular(DimenssionHelper.size50),
                    ),
                    child: Text(
                      '2024-03-29',
                      style: TextStyle(
                        color: ColorHelper.blackColor,
                        fontWeight: FontHelper.w400,
                        fontSize: FontHelper.font_14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: DimenssionHelper.size8,
      ),
      itemCount: 10,
    );
  }
}
