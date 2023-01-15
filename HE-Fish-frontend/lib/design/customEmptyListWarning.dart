import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../class/color_palette.dart';

class CustomEmptyListWarning extends StatefulWidget {
  const CustomEmptyListWarning(
      {Key? key, required this.header, required this.description})
      : super(key: key);
  final String header;
  final String description;

  @override
  State<CustomEmptyListWarning> createState() => _CustomEmptyListWarningState();
}

class _CustomEmptyListWarningState extends State<CustomEmptyListWarning> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("Where did all the fish go?",
            style: TextStyle(
                color: Palette.grey,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        Text("The plus button on the corner seems legit...",
            style: TextStyle(
                color: Palette.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400)),
      ],
    ));
  }
}
