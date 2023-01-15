import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/class/fishes.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hefish_finalproject/page/editFishPage.dart';
import 'package:http/http.dart' as http;

import '../class/color_palette.dart';
import '../class/google_auth.dart';
import '../class/host.dart';
import '../class/user.dart';
import '../design/animatedPageRoute.dart';
import 'fishesPage.dart';

class FishDetailPage extends StatefulWidget {
  final User user;
  final Fishes item;
  const FishDetailPage({super.key, required this.user, required this.item});

  @override
  State<FishDetailPage> createState() => _FishDetailPageState();
}

class _FishDetailPageState extends State<FishDetailPage> {
  Future<bool> deleteFish(int id) async {
    String url = "${Host.main}/fishes/delete-fish";

    var resp = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'id': id}));
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: SpeedDial(
        marginBottom: MediaQuery.of(context).size.height * 0.515,
        marginEnd: MediaQuery.of(context).size.width - 80,
        elevation: 0,
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Palette.accent,
        activeBackgroundColor: Palette.grey,
        foregroundColor: Palette.white,
        visible: widget.user.id == widget.item.authorId,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.transparent,
        overlayOpacity: 0.5,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.delete_forever_rounded),
            backgroundColor: Palette.error,
            foregroundColor: Palette.white,
            elevation: 0,
            onTap: () async {
              String errorMsg = "Fish article deleted";
              Color snackBG = Palette.error;
              if (await deleteFish(widget.item.id)) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.of(context).push(AnimatedPageRoute(
                    child: FishesPage(
                  widget.item.typeName,
                  user: widget.user,
                )));
              } else {
                errorMsg = "Something went wrong!";
              }
              final message = SnackBar(
                content: Text(errorMsg),
                backgroundColor: snackBG,
                duration: const Duration(seconds: 3),
              );
              ScaffoldMessenger.of(context).showSnackBar(message);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit_rounded),
            backgroundColor: Palette.accent,
            foregroundColor: Palette.white,
            elevation: 0,
            onTap: () {
              Navigator.of(context).push(AnimatedPageRoute(
                  child: EditFishPage(
                item: widget.item,
                user: widget.user,
              )));
            },
          ),
        ],
      ),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.overlay,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0,
                    0.2,
                    0.4,
                    0.6,
                    0.8,
                    1
                  ],
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(175, 0, 0, 0),
                    Color.fromARGB(100, 0, 0, 0),
                    Color.fromARGB(25, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ])),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.transparent,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                          color: Palette.white,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Palette.white),
                        )
                      ],
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      try {
                        await GoogleAuth.googleLogout();
                      } catch (e) {}
                      Navigator.popUntil(
                          context, (Route<dynamic> route) => route.isFirst);
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                      color: Palette.error,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.6,
              child: Image.network(
                "${Host.main}/${widget.item.imagePath}",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.55,
              child: Container(
                decoration: const BoxDecoration(
                    color: Palette.background,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.item.name,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Palette.black),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.item.price,
                          style: const TextStyle(
                              fontSize: 20, color: Palette.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Author",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.item.authorName,
                                style: const TextStyle(
                                    fontSize: 16, color: Palette.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Type",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.item.typeName,
                                style: const TextStyle(
                                    fontSize: 16, color: Palette.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.item.description,
                                style: const TextStyle(
                                    fontSize: 16, color: Palette.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
