import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';
import 'package:todo_bloc_retrofit/models/get_all_todo_model.dart';
import 'package:todo_bloc_retrofit/routes/route_name.dart';
import 'package:todo_bloc_retrofit/screens/delete_button.dart';
import 'package:todo_bloc_retrofit/screens/done_button.dart';
import 'package:todo_bloc_retrofit/utils/date_format.dart';

class Todo extends StatelessWidget {
  final List<Items> items;
  const Todo({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteName.addAndUpdateTodoScreen,
              arguments: {
                "type": 'update',
              },
            );
          },
          child: Container(
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
                        items[index].title!,
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
                  items[index].description!,
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
                    DoneButton(
                      items: items[index],
                    ),
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
                        dateFormat(items[index].createdAt!),
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
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: DimenssionHelper.size8,
      ),
      itemCount: items.length,
    );
  }
}
