import 'package:flutter/material.dart';
import 'package:hefish_finalproject/class/color_palette.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final double top;
  final IconData suffixIcon;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      required this.top,
      required this.suffixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Widget? iconSys;
  bool iconHidden = true;

  @override
  Widget build(BuildContext context) {
    if (widget.suffixIcon == Icons.visibility) {
      iconSys = IconButton(
        icon: Icon(
          iconHidden == true ? Icons.visibility_off : Icons.visibility,
          color: Palette.grey,
        ),
        onPressed: () {
          setState(() {
            iconHidden == true ? iconHidden = false : iconHidden = true;
          });
        },
      );
    } else if (widget.suffixIcon == Icons.abc) {
      iconSys = Icon(
        widget.suffixIcon,
        color: Palette.white,
      );
      iconHidden = false;
    } else {
      iconSys = Icon(widget.suffixIcon, color: Palette.grey);
      iconHidden = false;
    }
    return Padding(
        padding: EdgeInsets.only(top: widget.top),
        child: TextFormField(
          controller: widget.controller,
          style: const TextStyle(fontSize: 16),
          keyboardType: widget.keyboardType,
          obscureText: iconHidden,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  width: 0,
                )),
            suffixIcon: iconSys,
            filled: true,
            fillColor: Palette.white,
          ),
        ));
  }
}
