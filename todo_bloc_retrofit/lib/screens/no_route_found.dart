import 'package:flutter/material.dart';
import 'package:todo_bloc_retrofit/helper/string_helper.dart';

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(StringHelper.todoApp),
      ),
      body: const Center(
        child: Text(StringHelper.sorryThingWentWrong),
      ),
    );
  }
}
