import 'package:flutter/material.dart';
import 'package:frontend/screens/home/homeControllers.dart';
import 'dart:convert';
import 'dart:typed_data';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = HomeController();
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
      body: Text("ok"),
    );
  }

  getOneImage() {
    homeController.getCamerasVideos((frames) {});
  }
}
