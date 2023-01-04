import 'package:catalogscanner/main.dart';
import 'package:catalogscanner/widgets/loading_popup.dart';
import 'package:catalogscanner/widgets/tappable.dart';
import 'package:catalogscanner/widgets/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    this.popNavigationWhenDone = false,
    required this.setPage,
  }) : super(key: key);

  final bool popNavigationWhenDone;
  final Function(int) setPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OnBoardingPageBody(
      popNavigationWhenDone: popNavigationWhenDone,
      setPage: setPage,
    ));
  }
}

class OnBoardingPageBody extends StatefulWidget {
  const OnBoardingPageBody(
      {Key? key, this.popNavigationWhenDone = false, required this.setPage})
      : super(key: key);
  final bool popNavigationWhenDone;
  final Function(int) setPage;

  @override
  State<OnBoardingPageBody> createState() => OnBoardingPageBodyState();
}

class OnBoardingPageBodyState extends State<OnBoardingPageBody> {
  int currentIndex = 0;

  nextNavigation() async {
    if (widget.popNavigationWhenDone) {
      Navigator.pop(context);
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('firstLogin', false);
      widget.setPage(0);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    final List<Widget> children = [
      OnBoardPage(
        widgets: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFont(
                text: "Catalog Scanner",
                fontWeight: FontWeight.bold,
                fontSize: 35,
                textAlign: TextAlign.center,
                filter: (text) {
                  return text.capitalizeFirstofEach;
                },
                maxLines: 5,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Tappable(
                  onTap: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.acnh.pocket_guide',
                    );
                  },
                  borderRadius: 16,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const SizedBox(
                      height: 80,
                      width: 80,
                      child: Image(
                        image: AssetImage('assets/images/palmSplash.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const TextFont(
                text: "For ACNH Pocket Guide",
                fontSize: 16,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFont(
                  text: "Scan your collection from ACNH with ease!",
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  maxLines: 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      const OnBoardPage(
        widgets: [
          SizedBox(
            width: 500,
            height: 300,
            child: Image(
              image: AssetImage('assets/images/catalog.jpg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextFont(
              text:
                  "Open your catalog and select any category you want to scan",
              maxLines: 100,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      const OnBoardPage(
        widgets: [
          SizedBox(
            width: 300,
            height: 300,
            child: Image(
              image: AssetImage('assets/images/scan-screenshot.png'),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextFont(
              text: "Start scanning and point your camera at the list of items",
              maxLines: 100,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      OnBoardPage(
        widgets: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Tappable(
              onTap: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.acnh.pocket_guide',
                );
              },
              borderRadius: 16,
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const SizedBox(
                  height: 80,
                  width: 80,
                  child: Image(
                    image: AssetImage('assets/images/palmSplash.png'),
                  ),
                ),
              ),
            ),
          ),
          Icon(
            Icons.upload_file_rounded,
            size: 100,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFont(
              text: "Export your collection to the ACNH Pocket Guide App",
              fontSize: 20,
              textAlign: TextAlign.center,
              maxLines: 100,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          IntrinsicWidth(
            child: Tappable(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: 10,
              onTap: () {
                nextNavigation();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                child: Center(
                  child: TextFont(
                    fontSize: 20,
                    text: "Start Scanning!",
                    textColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                    textAlign: TextAlign.center,
                    filter: (text) {
                      return text.capitalizeFirstofEach;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    return Stack(
      children: [
        PageView(
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          controller: controller,
          children: children,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: currentIndex <= 0 ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: IconButton(
                        onPressed: () {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 1100),
                            curve: const ElasticOutCurve(1.3),
                          );
                        },
                        icon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ...List<int>.generate(children.length, (i) => i + 1)
                            .map(
                              (
                                index,
                              ) =>
                                  Builder(
                                builder: (BuildContext context) =>
                                    AnimatedScale(
                                  duration: const Duration(milliseconds: 900),
                                  scale: index - 1 == currentIndex ? 1.3 : 1,
                                  curve: const ElasticOutCurve(0.2),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    child: Container(
                                      key: ValueKey(index - 1 == currentIndex),
                                      width: 6,
                                      height: 6,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                        color: index - 1 == currentIndex
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.7)
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: currentIndex >= children.length - 1 ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: IconButton(
                        onPressed: () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 1100),
                            curve: const ElasticOutCurve(1.3),
                          );
                          if (currentIndex + 1 == children.length) {
                            nextNavigation();
                          }
                        },
                        icon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({Key? key, required this.widgets}) : super(key: key);
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          Column(
            children: widgets,
          )
        ],
      ),
    );
  }
}
