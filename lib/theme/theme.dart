import 'package:flutter/material.dart';

///
/// Definition of App colors.
///
class BlaColors {
  static Color primary            = const Color(0xFF00aff5);

  static Color backgroundAccent   = const Color(0xFFEDEDED);
 
  static Color neutralDark        = const Color(0xFF054752);
  static Color neutral            = const Color(0xFF3d5c62);
  static Color neutralLight       = const Color(0xFF708c91);
  static Color neutralLighter     = const Color(0xFF92A7AB);

  static Color greyLight          = const Color(0xFFE2E2E2);
  
  static Color white              = Colors.white;

  static Color get backGroundColor { 
    return BlaColors.primary;
  }

  static Color get textNormal {
    return BlaColors.neutralDark;
  }

  static Color get textLight {
    return BlaColors.neutralLight;
  }

  static Color get iconNormal {
    return BlaColors.neutral;
  }

  static Color get iconLight {
    return BlaColors.neutralLighter;
  }

  static Color get disabled {
    return BlaColors.greyLight;
  }
}
  
///
/// Definition of App text styles.
///
class BlaTextStyles {
  static TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: BlaColors.textNormal,
  );

  static TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: BlaColors.textNormal,
  );

  static TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: BlaColors.textNormal,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: BlaColors.textLight,
  );

  static TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: BlaColors.textLight,
  );

  static TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

///
/// Definition of App spacings, in pixels.
/// Bascially small (S), medium (m), large (l), extra large (x), extra extra large (xxl)
///
class BlaSpacings {
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16; 
  static const double l = 24; 
  static const double xl = 32; 
  static const double xxl = 40; 

  static const double radius = 16; 
  static const double radiusLarge = 24;
}

///
/// Definition of App Theme.
///
ThemeData appTheme = ThemeData(
  fontFamily: 'Eesti',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: BlaColors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
    titleTextStyle: BlaTextStyles.title,
  ),
);
