
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
Color kLightBlack = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;


IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");

IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: kAppPrimaryColor,
    boxShadow: [
      BoxShadow(
        color: kWhite,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: kWhite,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]
);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kHintTextStyleProfile = TextStyle(
  color: Colors.black38,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kLabelStyleProfile = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFFFAB00),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationStyleProfile = BoxDecoration(
  color: Colors.white70,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);