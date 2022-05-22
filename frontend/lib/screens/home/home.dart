import 'package:flutter/material.dart';
import 'package:frontend/screens/home/homeControllers.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = HomeController();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://10.0.0.12/night_video.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize().then((value) {});
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  homeController.go_to_alarms(context);
                },
                icon: Icon(Icons.alarm))
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              homeController.callDartMethod();
            },
            child: Text("click"),
          ),
        ));
  }
}
