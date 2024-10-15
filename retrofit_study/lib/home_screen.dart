import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_study/models/array_user_list.dart';
import 'package:retrofit_study/models/object_users_list.dart';
import 'package:retrofit_study/network_manager/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArrayUserList> arrayUsersList = [];
  ObjectUsersList objectUsersList = ObjectUsersList();
  bool loading = true;

  getUsers() {
    restClient.getArrayUsersList().then(((value) {
      setState(() {
        arrayUsersList = value;
        loading = false;
      });
    })).onError((error, stackTrace) {});
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    restClient.getObjectUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemPurple,
        title: const Text(
          '2 mint for APIs',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: arrayUsersList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(arrayUsersList[index].title ?? ""),
                  subtitle: Text(arrayUsersList[index].body ?? ""),
                );
              },
            ),
    );
  }
}
