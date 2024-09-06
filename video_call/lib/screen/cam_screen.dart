import 'package:flutter/material.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIVE"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            width: 120,
            height: 160,
            color: Colors.blue,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("나가기"),
            ),
          ),
        ],
      ),
    );
  }
}
