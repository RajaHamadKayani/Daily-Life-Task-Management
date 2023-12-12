import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddTaskFieldWidget extends StatelessWidget {
  String? title;
  double? containerWidth;
  TextEditingController? controller;  // Change to TextEditingController
  String? hintTextl;
  Widget? suffixWidget;
  Function()? ontap;

  AddTaskFieldWidget({
    Key? key,
    this.title,
    this.containerWidth,
    required this.controller,
    this.hintTextl,
    this.suffixWidget,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: TextFormField(
              readOnly: suffixWidget == null ? false : true,
              controller: controller,  // Use the provided controller
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintTextl ?? "",
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
                suffixIcon: suffixWidget,
              ),
            ),
          ),
        )
      ],
    );
  }
}
