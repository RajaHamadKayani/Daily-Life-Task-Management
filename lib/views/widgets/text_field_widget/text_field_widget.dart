import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  double? height;
  double? width;
  String? hintText;
  int? color;
  double? borderWidth;
  TextStyle? controllerStyle;
  TextStyle? hintStyle;
  double? borderRadius;
  VoidCallback? onTap;
  var suffixIcon;

  TextFieldWidget({
    Key? key,
    this.borderWidth,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
    this.controllerStyle,
    this.suffixIcon,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 0.0,
      width: width ?? 0.0,
      decoration: BoxDecoration(
        border: Border.all(color: Color(color ?? 0), width: borderWidth ?? 0.0),
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: TextFormField(
          style: controllerStyle,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: suffixIcon,
            ),
            border: InputBorder.none,
            hintText: hintText ?? "",
            hintStyle: hintStyle ?? TextStyle(color: Colors.grey), // Provide a default color
          ),
        ),
      ),
    );
  }
}
