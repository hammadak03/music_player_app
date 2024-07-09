import 'package:flutter/material.dart';
import 'package:music_player_app/utils/colors.dart';

textStyle(
    {double? size = 14,
    color = whiteColor,
    String? fontFamily,
    fontWeight = FontWeight.normal}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontSize: size,
    color: color,
  );
}
