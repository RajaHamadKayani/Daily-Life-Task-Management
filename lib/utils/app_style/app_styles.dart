import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final TextStyle headlineBold = GoogleFonts.rubik(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xff1D1617),
  );
  static final TextStyle headlineBoldWhite = GoogleFonts.rubik(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xffffffff),
  );
  static final TextStyle smallheadlineBoldBlack = GoogleFonts.rubik(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xff6B6B6B),
  );
  static final headlineMediumWhite = GoogleFonts.rubik(
      color: const Color(0xffFFECCC),
      fontSize: 30,
      fontWeight: FontWeight.w600);
  static final headlineRegularWhite = GoogleFonts.rubik(
      fontSize: 30,
      fontWeight: FontWeight.w300,
      color: const Color(0xffFFECCC));
  static final headlineMediumBlack = GoogleFonts.rubik(
      fontSize: 21,
      fontWeight: FontWeight.w600,
      color: const Color(0xff000000));
  static final smallHeadlineMediumBlack = GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: const Color(0xff573353));
  static final verySmallHeadlineMediumBlack = GoogleFonts.rubik(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: const Color(0xff573353));
  static final smallHeadlineMediumPurple = GoogleFonts.rubik(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: const Color(0xff4A4A4A));
  static final TextStyle headlineMediumBlue = GoogleFonts.poppins(
      color: const Color(0xff4D57C8),
      fontWeight: FontWeight.w600,
      fontSize: 17);
  static final TextStyle headlineMediumBluesmallSize = GoogleFonts.poppins(
      color: const Color(0xff4D57C8),
      fontWeight: FontWeight.w600,
      fontSize: 14);
  static final TextStyle smallHeadlineBoldBlue = GoogleFonts.poppins(
      color: const Color(0xff4D57C8),
      fontWeight: FontWeight.bold,
      fontSize: 17);
  static final regularBodyWhite = GoogleFonts.rubik(
      fontWeight: FontWeight.w300,
      color: const Color(0xffEBEAEC),
      fontSize: 16);
  static final TextStyle regularBodyBlack = GoogleFonts.rubik(
      fontWeight: FontWeight.w300,
      color: const Color(0xff7B6F72),
      fontSize: 16);
  static final TextStyle mediumBodyWhite = GoogleFonts.rubik(
      fontWeight: FontWeight.w600,
      color: const Color(0xffEBEAEC),
      fontSize: 16);
  static final TextStyle regularSmallBodyBlack = GoogleFonts.rubik(
    color: const Color(0xff6A6969),
    fontWeight: FontWeight.w300,
    fontSize: 11,
  );
  static final TextStyle mediumSmallBodyBlack = GoogleFonts.rubik(
    color: const Color(0xff6A6969),
    fontWeight: FontWeight.w600,
    fontSize: 11,
  );
  static final TextStyle smallRegularBodyWhite = GoogleFonts.rubik(
      fontWeight: FontWeight.w300,
      color: const Color(0xffEBEAEC),
      fontSize: 10);
  static final smallHeadlineMediumWhite = GoogleFonts.rubik(
      color: const Color(0xffFFECCC),
      fontSize: 18,
      fontWeight: FontWeight.w600);
  static final smallBodyBoldWhite = GoogleFonts.rubik(
      fontWeight: FontWeight.bold,
      color: const Color(0xffEEEEEE),
      fontSize: 20);
  static final TextStyle smallBodyMediumPurple = GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color(0xff573353));
  static final subTitleMediumWieghtLargeSizeBlack = GoogleFonts.rubik(
      fontSize: 33,
      fontWeight: FontWeight.w600,
      color: const Color(0xff573353));
  static final subTitleMediumWieghtLargeSizeWhite = GoogleFonts.rubik(
      fontSize: 33,
      fontWeight: FontWeight.w600,
      color: const Color(0xffffffff));
  static final subTitleMediumWieghtSmallSizeWhite = GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: const Color(0xffffffff));
  static final subTitleMediumWieghtSmallSizeBlack = GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: const Color(0xff6C6C6C));
  static final subTitleMediumWieghtVerySmallSizeWhite = GoogleFonts.rubik(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: const Color(0xffffffff));
  static final subtitleRegularBlueColor = GoogleFonts.rubik(
      fontWeight: FontWeight.w300,
      fontSize: 20,
      color: const Color(0xff4D57C8));
  static final subtitleRegularWhite = GoogleFonts.rubik(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: const Color(0xffffffff));
  static final subtitleMediumWhitePoppins = GoogleFonts.poppins(
      color: const Color(0xffffffff),
      fontSize: 16,
      fontWeight: FontWeight.w600);
  static final TextStyle regularSubtitleSmallSizeBlue = GoogleFonts.inter(
      color: const Color(0xff4D57C8),
      fontSize: 16,
      fontWeight: FontWeight.w300);
  static final TextStyle regularSubtitleVerySmallSizeBlue = GoogleFonts.inter(
      color: const Color(0xff4D57C8),
      fontSize: 12,
      fontWeight: FontWeight.w300);
  static final TextStyle regularSubtitleLargeSizeBlue = GoogleFonts.inter(
      color: const Color(0xff4D57C8),
      fontSize: 24,
      fontWeight: FontWeight.w300);
  static final TextStyle mediumSizedWhiteHeading = GoogleFonts.inter(
      color: const Color(0xffffffff),
      fontSize: 24,
      fontWeight: FontWeight.w300);
  static final TextStyle smallRegularBodyBlack = GoogleFonts.rubik(
      color: const Color(0xff000000),
      fontSize: 11,
      fontWeight: FontWeight.w300);
  static const Color appBgColor = Color(0xff4D57C8);
  static const Color containerBgColor = Color(0xff7889DF);
  static const Color whiteColor = Color(0xffffffff);
  static List<String> assetImages = [
    "assets/images/blue_bg.png",
    "assets/images/morning_walk.png",
    "assets/images/drinking_water.png"
  ];
  static List<String> texts = ["Drinking water", "Morning walk"];
  static List<String> weekDays = ["S", "M", "T", 'W', 'TH', 'F', 'S'];
  static List<String> durationTime = ["DAILY", 'WEEKLY', 'MONTHLY'];
  static List<String> days = ["Mon", 'Tue', 'Wed', 'Thur', "Fri", 'Sat', 'Sun'];
  static List<String> date = ['11', '12', '13', '14', '15', '16', '17'];
  static List<String> progressText = [
    "Drinking Water",
    'Cycling',
    'Water',
    'Walking'
  ];
  static List<String> progressPercent = ['75%', '40%', '40%', '65%'];
  static List<String> drawerText = [
    "Profile",
    "Today",
    "Your stats",
    "Challanges",
    "All habits",
    "Notification",
    "Setting",
    "Try Free"
  ];
  static List<String> imagesPath = [
    "assets/images/water_glass.png",
    "assets/images/cycle.png",
    "assets/images/water_drop.png",
    "assets/images/walk.png"
  ];
  static List<String> listTileTitle = [
    "Drinking 300ml Water",
    'Eat Snack(FitBar)'
  ];
  static List<String> listTileDescription = [
    "About 3 minutes ago",
    'About 10 minutes ago'
  ];
  static List<String> listTileLogo = [
    'assets/images/drinking_water_listTile.png',
    'assets/images/eating_snack_listTile.png'
  ];
  static List<String> notificationViewListTileTitle = [
    "Hey,its time for lunch",
    'Dont miss your lower body workout',
    'Hey,lets add some meals for you',
    'Congratulations,you have finished',
    'Hey,its time for lunch',
    'Ups,you have missed you lowerbody workout'
  ];
  static List<String> notificationViewListTileSubTitle = [
    "About 1 minutes ago",
    'About 3 hours ago',
    'About 3 hours ago',
    '29 May',
    '8 April',
    '3 April'
  ];
  static List<String> notifcationListTileLogo = [
    "assets/images/notifcation_1.png",
    "assets/images/notification_2.png",
    "assets/images/notification_3.png",
    "assets/images/notification_2.png",
    "assets/images/notification_2.png",
    "assets/images/notification_2.png"
  ];
  static List<String> settingsScreenListTileTitle = [
    "Profile",
    "Sound",
    "Vibration mode",
    "Login with web account",
    "Help",
    "Rate us",
    "Share App"
  ];
  static List<String> firstWeek = ["1", '2', '3', '4', '5', '6', '7'];
  static List<String> secondWeek = ["8", '9', '10', '11', '12', '13', '14'];
  static List<String> thirdWeek = ["15", '16', '17', '18', '19', '20', '21'];
  static List<String> fouthWeek = ["22", '23', '24', '25', '26', '27', '28'];
  static List<String> remainingDays = ["29", '30', "31"];
  static List<String> profileScreenList = ["7","8","6","6","4","6","7"];
}
