import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        children: [
          // 로고
          Expanded(
            child: _Logo(),
          ),
          // 이미지
          Expanded(
            child: _Image(),
          ),
          // 버튼
          Expanded(
            child: _Button(),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        child: Text("입장하기"),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("asset/img/home_img.png"),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!,
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam,
                color: Colors.white,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "LIVE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
