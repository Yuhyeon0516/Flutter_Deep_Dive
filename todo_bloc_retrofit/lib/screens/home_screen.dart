import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_retrofit/cubit/get_todo_list/cubit/get_todo_list_cubit.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/dimenssion_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';
import 'package:todo_bloc_retrofit/helper/string_helper.dart';
import 'package:todo_bloc_retrofit/routes/route_name.dart';
import 'package:todo_bloc_retrofit/screens/todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: ColorHelper.primaryColor,
          title: Text(
            StringHelper.todoApp,
            style: TextStyle(
              color: ColorHelper.whiteColor,
            ),
          ),
          bottom: TabBar(
            labelPadding: const EdgeInsets.symmetric(
              vertical: DimenssionHelper.size8,
            ),
            labelStyle: const TextStyle(
              // color: ColorHelper.whiteColor,
              fontWeight: FontHelper.w500,
              fontSize: FontHelper.font_20,
            ),
            unselectedLabelStyle: TextStyle(
              color: ColorHelper.whiteColor,
              fontWeight: FontHelper.w500,
              fontSize: FontHelper.font_18,
            ),
            tabs: const [
              Text(StringHelper.all),
              Text(StringHelper.todo),
              Text(StringHelper.done),
            ],
          ),
        ),
        body: BlocConsumer<GetTodoListCubit, GetTodoListState>(
          listener: (context, state) {
            debugPrint(state.toString());
          },
          builder: (context, state) {
            if (state is GetTodoListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetTodoListLoaded) {
              return TabBarView(
                children: [
                  Todo(
                    items: state.all,
                  ),
                  Todo(
                    items: state.todo,
                  ),
                  Todo(
                    items: state.done,
                  ),
                ],
              );
            }

            return const Center(
              child: Text('Something....?'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteName.addAndUpdateTodoScreen,
              arguments: {
                'type': 'add',
              },
            );
          },
          backgroundColor: ColorHelper.secondaryColor,
          child: Icon(
            Icons.add,
            color: ColorHelper.primaryColor,
          ),
        ),
      ),
    );
  }
}
