import 'package:flutter/material.dart';
import 'package:frontend/screens/home/home_controllers.dart';
import 'package:frontend/languages/laguages.dart';

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
    return FutureBuilder(
        future: languages.getLanguageCode(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return appMain(context);
        });
  }

  Scaffold appMain(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(languages.get("home")),
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

  void setLanguageInState(languageCode) {
    languages.setLanguageCode(languageCode);
    setState(() {
      languages.languageCode = languageCode;
    });
  }

  selectLanguages() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(languages.get("chooseYourLanguage")),
              content: FractionallySizedBox(
                heightFactor: .35,
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            setLanguageInState("es");
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
                          onPressed: () {
                            setLanguageInState("en");
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
              Text(
                languages.get("languages"),
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
              Text(
                languages.get("logout"),
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
