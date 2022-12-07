import 'dart:async';
import 'dart:convert';

import 'package:catalogscanner/pages/catalog_list.dart';
import 'package:catalogscanner/pages/home_page.dart';
import 'package:catalogscanner/widgets/camera_view.dart';
import 'package:catalogscanner/pages/text_detector_view.dart';
import 'package:catalogscanner/widgets/tappable.dart';
import 'package:catalogscanner/widgets/text_font.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:system_theme/system_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription> cameras = [];
Set<String> foundText = {};
bool firstLogin = false;

String foundTextToStringList() {
  String outString = "";
  for (String text in foundText.toList()) {
    outString += text + "\n";
  }
  return outString;
}

Future<bool> saveFoundText() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('foundText', foundText.toList());
  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await SystemTheme.accentColor.load();
  final prefs = await SharedPreferences.getInstance();
  List<String>? foundTextStringList = prefs.getStringList('foundText');
  foundText = (foundTextStringList ?? []).toSet();
  firstLogin = prefs.getBool('firstLogin') ?? true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalog Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: SystemTheme.accentColor.accent,
          brightness: Brightness.light,
          background: Colors.white,
        ),
        useMaterial3: true,
        applyElevationOverlayColor: false,
        canvasColor: Colors.white,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: SystemTheme.accentColor.accent,
          brightness: Brightness.dark,
          background: Colors.black,
        ),
        useMaterial3: true,
        canvasColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  void setPage(int page) {
    saveFoundText();
    setState(() {
      currentPage = page;
    });
  }

  List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(setPage: setPage),
      TextRecognizerPage(setPage: setPage),
      CatalogList(
        setPage: setPage,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (pages.isEmpty ? const SizedBox.shrink() : pages[currentPage]),
          OverlayStack(key: globalOverlayStackKey),
          OverlayCanScrollStack(key: globalOverlayCanScrollStackKey),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 70,
        ),
        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 1000),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.camera_rounded),
              label: "Scan",
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt_rounded),
              label: "Catalog",
            ),
          ],
          selectedIndex: currentPage,
          onDestinationSelected: setPage,
        ),
      ),
    );
  }
}

GlobalKey<OverlayCanScrollStackState> globalOverlayCanScrollStackKey =
    GlobalKey();

class OverlayCanScrollStack extends StatefulWidget {
  const OverlayCanScrollStack({super.key});

  @override
  State<OverlayCanScrollStack> createState() => OverlayCanScrollStackState();
}

class OverlayCanScrollStackState extends State<OverlayCanScrollStack> {
  bool canScroll = false;
  Timer? t;
  post(bool status) {
    if (t != null) t!.cancel();
    canScroll = status;
    setState(() {});
    t = Timer(const Duration(milliseconds: 500), () {
      canScroll = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).viewPadding.top,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        opacity: canScroll ? 1 : 0,
        child: Tappable(
          color: Theme.of(context).colorScheme.secondaryContainer,
          onTap: () {},
          borderRadius: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

GlobalKey<OverlayStackState> globalOverlayStackKey = GlobalKey();

class OverlayStack extends StatefulWidget {
  const OverlayStack({super.key});

  @override
  State<OverlayStack> createState() => OverlayStackState();
}

class OverlayStackState extends State<OverlayStack> {
  List<String> queue = [];

  post(String message) {
    queue.add(message);
    setState(() {});
    Future.delayed(const Duration(milliseconds: 1000), () {
      queue.removeAt(0);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (String string in queue)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 4),
              child: Tappable(
                color: Theme.of(context).colorScheme.secondaryContainer,
                onTap: () {},
                borderRadius: 7,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextFont(
                    text: string,
                    textColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
