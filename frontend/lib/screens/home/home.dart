import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/home/home_controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/alert/alert_question.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum SingingCharacter { lafayette, jefferson }

class _HomeState extends State<Home> {
  HomeController homeController = HomeController();
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.home),
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
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  homeController.testStartRunning();
                },
                child: const Text("click"),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("change"),
            )
          ],
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
                child: Text('Camara IA'),
              ),
            ),
            languajes(),
            SizedBox(height: homeController.setPositionToLogoutButton(context)),
            logoutButton()
          ],
        ),
      ),
    );
  }

  FractionallySizedBox languajes() {
    return FractionallySizedBox(
      widthFactor: .9,
      child: ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.languages,
                style: const TextStyle(fontSize: 20),
              ),
              const Icon(
                Icons.language,
              )
            ],
          )),
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
