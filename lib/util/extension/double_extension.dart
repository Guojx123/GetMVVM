import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension DoubleFit on double {
  double get width => ScreenUtil().setWidth(toDouble());

  double get height => ScreenUtil().setHeight(toDouble());

  double get sp => ScreenUtil().setSp(toDouble());

  SizedBox get heightBox => SizedBox(height: height);

  SizedBox get widthBox => SizedBox(width: width);

  String toFixed(int decimalPlace) {
    final buffer = StringBuffer();
    final List<String> strList = toString().split(".");
    if (strList[1].length < decimalPlace) {
      buffer.toString();
      for (int i = strList[1].length; i < decimalPlace; i++) {
        buffer.write("0");
      }
    } else {
      buffer.write("${strList[0]}.${strList[1].substring(0, decimalPlace)}");
    }
    return buffer.toString();
  }

  int get getDoubleDots => toString().split(".")[1].length;
}
