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
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.setPage});

  final Function(int) setPage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60 + MediaQuery.of(context).viewPadding.top),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TextFont(
                        text: "Catalog Scanner",
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        child: const Image(
                          image: AssetImage('assets/images/palmSplash.png'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: TextFont(
                          text: "For ACNH Pocket Guide",
                          fontSize: 16,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Tappable(
                      onTap: () {
                        widget.setPage(1);
                      },
                      borderRadius: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Icon(
                              Icons.camera_rounded,
                              size: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(height: 10),
                            TextFont(
                              text: "Scan Catalog",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Tappable(
                      onTap: () {
                        widget.setPage(2);
                      },
                      borderRadius: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              size: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(height: 10),
                            TextFont(
                              text: "View Catalog",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            TextFont(
                              text: foundText.length.toString() + " entries",
                              fontSize: 15,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Tappable(
                      onTap: () async {
                        exportData(context);
                      },
                      borderRadius: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.upload_file_rounded,
                              size: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(height: 10),
                            TextFont(
                              text: "Export Catalog",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Tappable(
                      onTap: () async {
                        _aboutGuideDaialog(context, widget.setPage);
                      },
                      borderRadius: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.document_scanner_rounded,
                              size: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(width: 6),
                            TextFont(
                              text: "Scanner Guide",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Tappable(
                      onTap: () async {
                        await _eraseCatalogDialog(context, () {
                          setState(() {});
                        });
                      },
                      borderRadius: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_forever_rounded,
                              size: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(width: 6),
                            TextFont(
                              text: "Erase Catalog",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Tappable(
                      onTap: () async {
                        _infoDaialog(context);
                      },
                      borderRadius: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_rounded,
                              size: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            const SizedBox(width: 6),
                            TextFont(
                              text: "App Info",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

void exportData(context) async {
  bool success = false;
  openLoadingPopup(context);
  try {
    await Future.delayed(Duration(milliseconds: 500));
    await Clipboard.setData(
      ClipboardData(
        text: foundTextToStringList(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard!'),
      ),
    );
    success = true;
  } catch (e) {
    try {
      await FlutterShare.share(
        title: 'Catalog Scanning Data',
        text: foundTextToStringList(),
        chooserTitle: 'Catalog Scanning Data',
      );
      success = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There was an error exporting data!'),
        ),
      );
    }
  }
  Navigator.pop(context);
  if (success) {
    await _exportGuideDaialog(context);
  }
}

Future<void> _eraseCatalogDialog(context, Function onDone) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Erase Catalog?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              TextFont(
                text: "This will delete your entire scanned collection.",
                maxLines: 100,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              TextFont(
                text: "This cannot be undone.",
                maxLines: 100,
                fontSize: 16,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              foundText = {};
              saveFoundText();
              onDone();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _exportGuideDaialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: const Text('You\'re good to go!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                TextFont(
                  text: "Open ACNH Pocket Guide",
                  maxLines: 100,
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  height: 70,
                  child: Image(
                    image: AssetImage('assets/images/app-icon.png'),
                  ),
                ),
                SizedBox(height: 10),
                TextFont(
                  text: "Open the catalog scanner page",
                  maxLines: 100,
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  height: 70,
                  child: Image(
                    image:
                        AssetImage('assets/images/catalog-scanning-option.png'),
                  ),
                ),
                SizedBox(height: 10),
                TextFont(
                  text: "Paste your collection in the list text box",
                  maxLines: 100,
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  height: 280,
                  child: Image(
                    image: AssetImage('assets/images/catalog-scanner-page.png'),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Open ACNH Pocket Guide'),
              onPressed: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.acnh.pocket_guide',
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _aboutGuideDaialog(context, Function(int) setPage) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        title: const Text('Scanner Usage'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFont(
                  text: "Open ACNH on your Switch",
                  maxLines: 100,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFont(
                  text:
                      "Open your catalog and select any category you want to scan",
                  maxLines: 100,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 2000,
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/catalog.jpg'),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFont(
                  text: "Point your camera at the list of items",
                  maxLines: 100,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/scan-screenshot.png'),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFont(
                  text:
                      "Tip: When you see the scroll arrow in the top right, use the right joy-con to scroll your catalog. This icon appears when it has scanned everything on that page.",
                  maxLines: 100,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Start Scanning!'),
            onPressed: () {
              Navigator.of(context).pop();
              setPage(1);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _infoDaialog(context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('About App'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const TextFont(
                text:
                    "This app was made to work directly with ACNH Pocket Guide.",
                maxLines: 100,
                fontSize: 16,
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(
                      image: AssetImage('assets/images/james.png'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextFont(
                    text: "James",
                    maxLines: 100,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const TextFont(
                    text: "Lead Developer",
                    maxLines: 100,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Uri url =
                          Uri.parse('mailto:dapperappdeveloper@gmail.com');
                      await launchUrl(url);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFont(
                        text: "dapperappdeveloper@gmail.com",
                        maxLines: 100,
                        fontSize: 14.5,
                        textAlign: TextAlign.center,
                        textColor: Colors.blue[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Tappable(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: 10,
                onTap: () {
                  showLicensePage(
                      context: context,
                      applicationLegalese:
                          "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.");
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: TextFont(
                      fontSize: 15,
                      text: "View Licenses",
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Start Scanning!'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
