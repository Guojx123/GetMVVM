import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension IntFit on int {
  double get width => ScreenUtil().setWidth(toDouble());

  double get height => ScreenUtil().setHeight(toDouble());

  double get sp => ScreenUtil().setSp(toDouble());

  SizedBox get heightBox => SizedBox(height: height);

  SizedBox get widthBox => SizedBox(width: width);

  Future get millisecondsDelay async =>
      Future.delayed(Duration(milliseconds: this));

  String toFixed(int decimalPlace) {
    final buffer = StringBuffer();
    final List<String> strList = toString().split(".");
    if (strList[1].length < decimalPlace) {
      buffer.toString();
      for (int i = strList[1].length; i < decimalPlace; i++) {
        buffer.write("0");
      }
    } else {
      buffer.write(
          "${strList[0]}.${strList[1].substring(0, max(decimalPlace, strList[1].length))}");
    }
    return buffer.toString();
  }
}
