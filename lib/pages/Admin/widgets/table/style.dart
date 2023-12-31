//import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Admin/style/base_style.dart';

enum BorderType { top, left, right, bottom, all }

typedef OnStripe = Color Function(int index);

class AdminTableStyle extends BaseStyle {
  // zebra style
  final OnStripe? stripe;
  final bool border;
  final Color borderColor;
  final double borderWidth;
  final BorderType borderType;

  AdminTableStyle(
      {super.background,
      required this.stripe,
      required this.border,
      required this.borderColor,
      required this.borderWidth,
      required this.borderType});
}

class AdminTableItemStyle {
  final MaterialStateProperty<Color> backgroundColor;

  AdminTableItemStyle({required this.backgroundColor});

}
