import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null
          ? _VideoPlayer(
              video: video!,
              onAnotherVideoPressed: onLogoTaped,
            )
          : _VideoSelector(onLogoTaped: onLogoTaped),
    );
  }

  onLogoTaped() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      this.video = video;
    });
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

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onAnotherVideoPressed;
  const _VideoPlayer({
    super.key,
    required this.video,
    required this.onAnotherVideoPressed,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool showIcons = true;

  @override
  void initState() {
    super.initState();

    initializedController();
  }

  @override
  didUpdateWidget(covariant _VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializedController();
    }
  }

  initializedController() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));

    await videoPlayerController.initialize();

    videoPlayerController.addListener(() {
      setState(() {});
    });

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showIcons = !showIcons;
        });
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController),
              if (showIcons)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
              if (showIcons)
                _PlayButtons(
                  onReversePressed: onReversePressed,
                  onPlayPressed: onPlayPressed,
                  onForwardPressed: onForwardPressed,
                  isPlaying: videoPlayerController.value.isPlaying,
                ),
              _Bottom(
                position: videoPlayerController.value.position,
                maxPosition: videoPlayerController.value.duration,
                onSliderChanged: onSliderChanged,
              ),
              if (showIcons)
                _PickAnotherVideo(
                  onPressed: widget.onAnotherVideoPressed,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double value) {
    final position = Duration(seconds: value.toInt());

    videoPlayerController.seekTo(position);
  }

  void onForwardPressed() {
    final maxPosition = videoPlayerController.value.duration;
    final currentPosition = videoPlayerController.value.position;

    Duration position = maxPosition;

    if ((maxPosition - const Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + const Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }

  void onPlayPressed() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }

    setState(() {});
  }

  void onReversePressed() {
    final currentPosition = videoPlayerController.value.position;

    Duration position = const Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }
}

class _PickAnotherVideo extends StatelessWidget {
  final VoidCallback onPressed;
  const _PickAnotherVideo({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.photo_camera_back),
        color: Colors.white,
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final Duration position;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _Bottom({
    super.key,
    required this.position,
    required this.maxPosition,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 8,
      left: 8,
      child: Row(
        children: [
          Text(
            "${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Slider(
              value: position.inSeconds.toDouble(),
              max: maxPosition.inSeconds.toDouble(),
              onChanged: onSliderChanged,
            ),
          ),
          Text(
            "${maxPosition.inMinutes.toString().padLeft(2, '0')}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButtons extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _PlayButtons({
    super.key,
    required this.onReversePressed,
    required this.onPlayPressed,
    required this.onForwardPressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onReversePressed,
            icon: const Icon(Icons.rotate_left),
            color: Colors.white,
          ),
          IconButton(
            onPressed: onPlayPressed,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            color: Colors.white,
          ),
          IconButton(
            onPressed: onForwardPressed,
            icon: const Icon(Icons.rotate_right),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
