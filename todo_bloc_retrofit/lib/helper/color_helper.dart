import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorHelper {
  ColorHelper._();

  static final ColorHelper colorHelper = ColorHelper._();

  factory ColorHelper() {
    return colorHelper;
  }

  static Color primaryColor = HexColor('#9499ff');
  static Color secondaryColor = HexColor('#ffc7c8');
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color greyColor = Colors.grey;
  static Color redColor = Colors.red;
}
