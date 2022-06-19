import 'package:flutter/material.dart';
import 'package:frontend/screens/home/home_controllers.dart';
import 'package:frontend/languages/laguages.dart';
import 'package:frontend/widgets/text/text_language.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = HomeController();
  Languages languages = Languages();
  @override
  Widget build(BuildContext context) {
    return appMain(context);
  }

  Scaffold appMain(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextLanguage("home"),
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
          child: const Icon((Icons.camera_enhance)),
          onPressed: () {
            homeController.addCamera(mounted, context);
          },
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
                child: Text('Camara IA'),
              ),
            ),
            languagesButton(),
            SizedBox(height: homeController.setPositionToLogoutButton(context)),
            logoutButton()
          ],
        ),
      ),
    );
  }

  Future<void> setLanguageInState(languageCode) async {
    await languages.setLanguageCode(languageCode);
    setState(() {
      languages.languageCode = languageCode;
    });
  }

  selectLanguages() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: TextLanguage("chooseYourLanguage"),
              content: FractionallySizedBox(
                heightFactor: .35,
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                          onPressed: () async {
                            await setLanguageInState("es");
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Español",
                          )),
                    ),
                    const Divider(
                      color: Color.fromARGB(204, 0, 0, 0),
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                          onPressed: () async {
                            await setLanguageInState("en");
                            Navigator.pop(context);
                          },
                          child: const Text("English")),
                    ),
                  ],
                ),
              ));
        });
  }

  FractionallySizedBox languagesButton() {
    return FractionallySizedBox(
      widthFactor: .9,
      child: ElevatedButton(
          onPressed: () {
            selectLanguages();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextLanguage(
                "languages",
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
            children: [
              TextLanguage(
                "logout",
                style: const TextStyle(fontSize: 20),
              ),
              const Icon(
                Icons.logout,
              )
            ],
          )),
    );
  }
}
