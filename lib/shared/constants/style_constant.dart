import 'package:flutter/material.dart';
import 'package:gutenread/shared/constants/color_constant.dart';
import 'package:gutenread/shared/constants/text_constant.dart';

TextStyle get defaultStyle => TextStyle(
  fontSize: 15,
  color: Colors.grey[600],
  fontFamily: fontFamilyApp,
);

TextStyle get readMoreStyle => TextStyle(
  color: Colors.blueAccent,
  fontWeight: FontWeight.w600,
  fontFamily: fontFamilyApp,
);

TextStyle get titleStyle => TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: fontFamilyApp,
);

TextStyle get subTitleRedStyle => TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: mainRedColor,
  fontFamily: fontFamilyApp,
);

TextStyle get subTitleStyle => TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  fontFamily: fontFamilyApp,
);

TextStyle get descriptionStyle => TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontFamily: fontFamilyApp,
);

TextStyle get descriptionBoldStyle => TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  fontFamily: fontFamilyApp,
);

TextStyle get smallTextStyle => TextStyle(
    fontSize: 12,
    color: Colors.grey[600],
    fontFamily: fontFamilyApp,
);

TextStyle get buttonTextStyle => TextStyle(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: fontFamilyApp,
);
