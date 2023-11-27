import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddTaskFieldWidget extends StatelessWidget {
  String? title;
  double? containerWidth;
  dynamic controller;
  String? hintTextl;
  dynamic suffixIcon;
  Function()? ontap;
  AddTaskFieldWidget(
      {super.key,
      this.title,
      this.containerWidth,
      required this.controller,
      this.hintTextl,
      this.suffixIcon,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
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
              controller: controller,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintTextl ?? "",
                  hintStyle: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                  suffixIcon: GestureDetector(
                      onTap: ontap,
                      child: Icon(
                        suffixIcon ?? null,
                        color: Colors.grey,
                      ))),
            ),
          ),
        )
      ],
    );
  }
}
