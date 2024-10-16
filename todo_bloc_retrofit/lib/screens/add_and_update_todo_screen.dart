import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_retrofit/cubit/add_and_update_todo/add_and_update_todo_cubit.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';
import 'package:todo_bloc_retrofit/helper/string_helper.dart';
import 'package:todo_bloc_retrofit/models/add_and_update_todo_model.dart';

class AddAndUpdateTodoScreen extends StatefulWidget {
  final Map args;
  final String id;

  const AddAndUpdateTodoScreen({super.key, required this.args, this.id = ''});

  @override
  State<AddAndUpdateTodoScreen> createState() => _AddAndUpdateTodoScreenState();
}

class _AddAndUpdateTodoScreenState extends State<AddAndUpdateTodoScreen> {
  String type = '';
  bool isDone = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.args.containsKey('type')) {
      type = widget.args['type'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: ColorHelper.whiteColor,
        ),
        backgroundColor: ColorHelper.primaryColor,
        title: Text(
          type == 'add' ? StringHelper.addTodo : StringHelper.updateTodo,
          style: TextStyle(
            color: ColorHelper.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimenssionHelper.size10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(
                fontSize: FontHelper.font_20,
                fontWeight: FontWeight.w500,
                color: ColorHelper.blackColor,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: FontHelper.font_20,
                  fontWeight: FontWeight.w500,
                  color: ColorHelper.blackColor,
                ),
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              controller: descriptionController,
              style: TextStyle(
                fontSize: FontHelper.font_18,
                fontWeight: FontWeight.w500,
                color: ColorHelper.blackColor,
              ),
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                  fontSize: FontHelper.font_18,
                  fontWeight: FontWeight.w500,
                  color: ColorHelper.blackColor,
                ),
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringHelper.done,
                  style: TextStyle(
                    fontSize: FontHelper.font_18,
                    fontWeight: FontWeight.w500,
                    color: ColorHelper.blackColor,
                  ),
                ),
                Switch(
                  value: isDone,
                  activeColor: ColorHelper.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isDone = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: DimenssionHelper.size30,
            ),
            BlocProvider(
              create: (context) => AddAndUpdateTodoCubit(),
              child: BlocConsumer<AddAndUpdateTodoCubit, AddAndUpdateTodoState>(
                listener: (context, state) {
                  debugPrint(state.toString());
                },
                builder: (context, state) {
                  return SizedBox(
                    height: DimenssionHelper.size45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AddAndUpdateTodoCubit>().addAndUpdateTodo(
                              context,
                              type,
                              AddAndUpdateTodoModel(
                                title: titleController.text.toString().trim(),
                                description: descriptionController.text
                                    .toString()
                                    .trim(),
                                isCompleted: isDone,
                              ),
                              widget.id,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorHelper.secondaryColor,
                        foregroundColor: ColorHelper.primaryColor,
                      ),
                      child: Text(
                        type == 'add'
                            ? StringHelper.addTodo
                            : StringHelper.updateTodo,
                        style: TextStyle(
                          color: ColorHelper.whiteColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
