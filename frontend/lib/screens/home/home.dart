import 'package:flutter/material.dart';
import 'package:frontend/screens/home/home_controllers.dart';

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
          title: const Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  homeController.goToAlarms(context);
                },
                icon: const Icon(Icons.alarm))
          ],
        ),
        drawer: menu(context),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            icon: const Icon(Icons.camera_enhance),
            onPressed: () {},
          ),
          onPressed: () {},
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              homeController.testStartRunning();
            },
            child: const Text("click"),
          ),
        ));
  }

  Drawer menu(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
            ),
            SizedBox(height: homeController.setPositionToLogoutButton(context)),
            logoutButton()
          ],
        ),
      ),
    );
  }

  FractionallySizedBox logoutButton() {
    return FractionallySizedBox(
      widthFactor: .9,
      child: ElevatedButton(
          onPressed: () {
            homeController.deleteSession(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Log out ",
                style: TextStyle(fontSize: 20),
              ),
              Icon(
                Icons.logout,
              )
            ],
          )),
    );
  }
}
