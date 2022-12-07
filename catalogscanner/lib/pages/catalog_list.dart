import 'package:catalogscanner/main.dart';
import 'package:catalogscanner/pages/home_page.dart';
import 'package:catalogscanner/widgets/tappable.dart';
import 'package:catalogscanner/widgets/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CatalogList extends StatefulWidget {
  const CatalogList({super.key, required this.setPage});

  final Function(int) setPage;

  @override
  State<CatalogList> createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  Set searchFoundText = foundText;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.setPage(0);
        return false;
      },
      child: Stack(children: [
        Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFont(
                        text: "Catalog",
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: TextFont(
                          text: searchFoundText.length.toString() + " entries",
                          fontSize: 15,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              foundText.isEmpty
                  ? const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    )
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Tappable(
                                onTap: () async {
                                  exportData(context);
                                },
                                borderRadius: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload_file_rounded,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                      const SizedBox(width: 6),
                                      TextFont(
                                        text: "Export Catalog",
                                        fontSize: 15,
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
                    ),
              foundText.isEmpty
                  ? const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    )
                  : SliverToBoxAdapter(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            filled: true,
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                            suffixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(Icons.search_rounded),
                            ),
                          ),
                          onChanged: (text) {
                            if (text != "") {
                              setState(() {
                                searchFoundText = foundText.where((i) {
                                  return i
                                      .toLowerCase()
                                      .contains(text.toLowerCase());
                                }).toSet();
                                searchQuery = text;
                              });
                            } else {
                              setState(() {
                                searchFoundText = foundText;
                                searchQuery = text;
                              });
                            }
                          },
                        ),
                      ),
                    ),
              foundText.isEmpty
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25),
                              child: TextFont(
                                text: "No entries scanned.",
                                fontWeight: FontWeight.bold,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Tappable(
                                    onTap: () {
                                      widget.setPage(1);
                                    },
                                    borderRadius: 15,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    ),
              foundText.isEmpty
                  ? const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            child: Row(
                              children: [
                                Tappable(
                                  onTap: () async {
                                    String keyToRemove =
                                        searchFoundText.toList()[index];
                                    foundText.remove(keyToRemove);
                                    await saveFoundText();
                                    if (searchQuery != "") {
                                      setState(() {
                                        searchFoundText = foundText.where((i) {
                                          return i.toLowerCase().contains(
                                              searchQuery.toLowerCase());
                                        }).toSet();
                                      });
                                    } else {
                                      setState(() {});
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Deleted ' + keyToRemove),
                                      ),
                                    );
                                  },
                                  borderRadius: 5,
                                  color: Theme.of(context).colorScheme.primary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.delete_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                TextFont(
                                  text:
                                      '${index + 1}. ${searchFoundText.toList()[index]}',
                                  textAlign: TextAlign.start,
                                  maxLines: 4,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: searchFoundText.length,
                      ),
                    ),
            ],
          ),
        ),
        // Positioned(
        //   top: MediaQuery.of(context).viewPadding.top,
        //   left: 0,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       widget.setPage(0);
        //     },
        //     child: Icon(
        //       Icons.arrow_back_rounded,
        //       size: 35,
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
