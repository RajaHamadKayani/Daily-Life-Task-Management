import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ReusableListTileContainer extends StatelessWidget {
  String? title;
  String? description;
  Widget? widget;
  String? trailingLogo;
  double? borderRadius;
  double? trailingLogoHeight;
  double? trailingLogoWidth;
  String? image;
  double? width;
  double height;
  double? logoHeight;
  double? logoWidth;
  double? fontSizeTitle;
  FontWeight? fontWeightTile;
  double? fontSizeSubtitle;
  FontWeight? fontWeightSubtitle;
  int? subTitleColor;
  int? titleColor;
  int? color;
  Widget? trailingWidget;
  ReusableListTileContainer(
      {super.key,
      this.borderRadius,
      this.trailingLogoHeight,
      this.trailingLogoWidth,
      this.widget,
      this.description,
      this.trailingLogo,
      this.image,
      this.title,
      this.subTitleColor,
      this.titleColor,
      this.width,
      required this.height,
      this.trailingWidget,
      this.logoHeight,
      this.logoWidth,
      this.fontSizeSubtitle,
      this.fontSizeTitle,
      this.fontWeightSubtitle,
      this.fontWeightTile,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: width ?? 0.0,
        height: height,
        decoration: BoxDecoration(
            color: Color(color ?? 0),
            borderRadius: BorderRadius.circular(borderRadius ?? 16)),
        child: Padding(
          padding: const EdgeInsets.only(top: 7, left: 5),
          child: ListTile(
            title: Text(
              title ?? "",
              style: GoogleFonts.rubik(
                  fontWeight: fontWeightTile,
                  fontSize: fontSizeTitle ?? 0,
                  color: Color(titleColor ?? 0XFF000000)),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description ?? '',
                  style: GoogleFonts.rubik(
                      fontWeight: fontWeightSubtitle,
                      fontSize: fontSizeSubtitle ?? 0,
                      color: Color(subTitleColor ?? 0xFF000000)),
                ),
                const SizedBox(
                  height: 31,
                ),
                widget ?? Container()
              ],
            ),
            leading:trailingWidget ?? Container()
          ),
        ),
      ),
    );
  }
}
