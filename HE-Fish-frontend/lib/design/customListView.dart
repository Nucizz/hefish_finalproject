import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../class/color_palette.dart';
import '../class/fishes.dart';
import '../class/host.dart';
import '../class/user.dart';
import '../page/fishDetailPage.dart';
import 'animatedPageRoute.dart';

class CustomListView extends StatefulWidget {
  final Fishes item;
  final User user;

  const CustomListView({super.key, required this.item, required this.user});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(AnimatedPageRoute(
              child: FishDetailPage(
            item: widget.item,
            user: widget.user,
          )));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Palette.background,
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  "${Host.main}/${widget.item.imagePath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Palette.black),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.item.price,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Palette.grey),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
