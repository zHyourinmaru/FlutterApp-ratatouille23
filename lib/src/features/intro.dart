import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:video_player/video_player.dart';
import 'authentication/login.dart';
import '../constants/transitions.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset("assets/video/logo_anim_green1.mp4")
          ..initialize().then((_) {
            _controller.setVolume(0);
            _controller.play();

            _controller.addListener(() {
              if (_controller.value.position == _controller.value.duration) {
                // esegui azione alla fine del video
                Navigator.pushAndRemoveUntil(
                    context,
                    SlideLeftRoute(page: const Login()),
                    ModalRoute.withName("/Login"));
              }
            });
          });

    /*
    _controller =
        VideoPlayerController.asset('assets/video/logo_anim_green1.mp4')
          ..addListener(() => setState(() {}))
          ..initialize().then((_) => _controller.play())
          ..addListener(() {
            if (_controller.value.position == _controller.value.duration) {
              // esegui azione alla fine del video
              Navigator.pushAndRemoveUntil(
                  context,
                  SlideLeftRoute(page: const Login()),
                  ModalRoute.withName("/Login"));
            }
          });
          */
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainGreen,
      body: Center(
          child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: buildVideo()))),
    );
  }

  Widget buildVideo() => buildVideoPlayer();
  Widget buildVideoPlayer() => VideoPlayer(_controller);
}
