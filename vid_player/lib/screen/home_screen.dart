import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showVideoPlayer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showVideoPlayer
          ? const _VideoPlayer()
          : _VideoSelector(onLogoTaped: onLogoTaped),
    );
  }

  onLogoTaped() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    print(video);
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTaped;
  const _VideoSelector({
    super.key,
    required this.onLogoTaped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTaped,
          ),
          const SizedBox(
            height: 28,
          ),
          const _Title(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "VIDEO",
          style: textStyle.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          "PLAYER",
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;
  const _Logo({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  const _VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Video Player"),
    );
  }
}
