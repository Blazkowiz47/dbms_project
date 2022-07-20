import 'package:flutter/material.dart';

// Net width 375
// Net height height
// 234 0.624
// 172.19 0.45917
// 100 0.2667
final double BigPie = 0.624;
final double MediumPie = 0.45917;
final double SmallPie = 0.2667;

// Net width 68
// Net height height
// 44 0.647
// 30.19 0.4412
// 16 0.2353
final screenHeight =
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
final screenWidth =
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

final buttonFieldHeight = screenHeight * 0.065;
final buttonFieldWidth = screenWidth * 0.8;

final double BigPieMini = 0.624;
final double MediumPieMini = 0.45917;
final double SmallPieMini = 0.2667;

final double SmallGraphContainerWidth = 0.182;
final double SmallGraphContainerAspectRatio = 0.94;
final double SmallContainerAspectRatio = 1.707;

final double MainScreenPadding = 0.042;

final double smallVP = screenHeight * 0.020;
final double smallHP = screenHeight * 0.020;
final double GraphCardHeight = 0.76;

final double smallTextSize = screenHeight * 0.015;
final double defaultTextSizeInHeightRelation = 0.017;
final double bigTextSize = screenHeight * 0.025;
final double headingTextSize = screenHeight * 0.039;
final double appTitleSize = screenHeight * 0.02;

/// Ad section in nutrition
final double aspectRatioAdSection = 1.130677;
final double aspectRatioAdVideo = 0.751879699;
final double aspectRatioAdColSection = 0.72;
final double cardHeadingFontSize = screenHeight * 0.02;

final defaultTextStyle = TextStyle(
  color: Colors.black,
  fontSize: screenHeight * defaultTextSizeInHeightRelation < 14
      ? 14
      : screenHeight * defaultTextSizeInHeightRelation,
);

final double mealTimeListItemWidth = 0.18133 * screenWidth;
final double mealTimeListItemHeight = 1.2941 * 0.18133 * screenWidth;

// TextStyle defaultTextStyle(double height) {
//   return TextStyle(
//     color: textDefaultColor,
//     fontSize:
//         MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height *
//             defaultTextSize,
//   );
// }

final BorderRadius defaultCardRadius = BorderRadius.circular(15);

final double defaultCardPaddingVertical = 16;

EdgeInsets defaultCardPadding(double width) {
  return EdgeInsets.symmetric(
    horizontal: width * MainScreenPadding,
    vertical: smallVP,
  );
}

EdgeInsets defaultHeadingTextPadding(double width) {
  return EdgeInsets.symmetric(
    horizontal: width * MainScreenPadding,
  );
}

final customerServiceCardWidth = 0.84;
final customerServiceCardAspectRation = 1.15;
final buttonHeightRatio = 0.06;
