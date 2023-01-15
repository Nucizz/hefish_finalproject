// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/class/color_palette.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hefish_finalproject/class/google_auth.dart';
import 'package:http/http.dart' as http;

import '../class/host.dart';
import '../class/user.dart';
import '../design/animatedPageRoute.dart';
import 'fishesPage.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class CarouselImage {
  String imagePath;

  CarouselImage({required this.imagePath});

  factory CarouselImage.fromJson(Map<String, dynamic> json) {
    return CarouselImage(imagePath: json['image_path'].toString());
  }
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> carousel_img;

  Future<List<String>> fetchCarouselData() async {
    String url = "${Host.main}/fishes/getCarouselImage";
    var resp = await http.get(Uri.parse(url));
    var res = jsonDecode(resp.body);

    List<String> itemList = [];

    for (var i in res) {
      itemList.add(CarouselImage.fromJson(i).imagePath);
    }

    return itemList;
  }

  String getGreetings(String name) {
    var dt = DateTime.now();
    if (name.length > 18) {
      return "Hi";
    } else if (name.length > 12) {
      return "Welcome";
    } else if (dt.hour < 11) {
      return "Good morning";
    } else if (dt.hour < 15) {
      return "Good day";
    } else if (dt.hour < 19) {
      return "Good evening";
    } else {
      return "Good night";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carousel_img = fetchCarouselData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Palette.background,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
              child: Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "assets/images/HEfish logo no-text.png",
                          height: 30,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: const [
                            Text(
                              "HE ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.black),
                            ),
                            Text(
                              "Fish",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: Palette.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${getGreetings(widget.user.username)}, ${widget.user.username}!",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: FutureBuilder(
                    future: carousel_img,
                    builder: (context, snapshot) {
                      var imageList = snapshot.data as List<String>?;
                      if (imageList!.isEmpty) {
                        List<String> imageListBackup = [
                          'assets/images/carousel/1.png',
                          'assets/images/carousel/2.jpg',
                          'assets/images/carousel/3.jpg',
                          'assets/images/carousel/4.jpg',
                          'assets/images/carousel/5.jpg'
                        ];
                        return CarouselSlider(
                          items: imageListBackup
                              .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 360,
                                      width: 270,
                                    ),
                                  )))
                              .toList(),
                          options: CarouselOptions(
                            height: 350,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1500),
                            autoPlayInterval: const Duration(seconds: 3),
                            enableInfiniteScroll: true,
                            enlargeCenterPage: false,
                            disableCenter: true,
                          ),
                        );
                      } else {
                        return CarouselSlider(
                          items: imageList
                              .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.network("${Host.main}/$e",
                                        fit: BoxFit.cover,
                                        height: 360,
                                        width: 270),
                                  )))
                              .toList(),
                          options: CarouselOptions(
                            height: 350,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1500),
                            autoPlayInterval: const Duration(seconds: 3),
                            enableInfiniteScroll: true,
                            enlargeCenterPage: false,
                            disableCenter: true,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Collections",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_fresh water.png",
                                        height: 85,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Fresh Water",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "Fresh Water",
                                  user: widget.user,
                                )));
                              },
                            )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_salt water.png",
                                        width: double.infinity,
                                        height: 85,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Salt Water",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "Salt Water",
                                  user: widget.user,
                                )));
                              },
                            ))
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_brackish water.png",
                                        height: 85,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Brackish Water",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "Brackish Water",
                                  user: widget.user,
                                )));
                              },
                            )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_all ecosystems.png",
                                        height: 85,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "All Ecosystems",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "All Ecosystems",
                                  user: widget.user,
                                )));
                              },
                            ))
                          ],
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
