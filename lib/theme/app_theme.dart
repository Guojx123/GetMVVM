import 'package:flutter/material.dart';
import 'package:flutterdemo/theme/dark_color.dart';
import 'package:flutterdemo/theme/light_color.dart';
import 'package:flutterdemo/theme/theme_color.dart';
import 'package:get/get.dart';

class AppTheme {
  /// 正常模式主题设置
  static final ThemeData lightTheme = ThemeData(brightness: Brightness.light);

  /// 黑暗模式主题设置
  static final ThemeData _darkTheme = ThemeData(brightness: Brightness.dark);

  static final LightColor _lightColor = LightColor();
  static final DarkColor _darkColor = DarkColor();

  static ThemeColor themeColor = _lightColor;

  /// 切换主题
  static Future<void> changeThemeMode(
      {ThemeMode themeMode = ThemeMode.system}) async {
    /// 注意样式设置
    switch (themeMode) {
      case ThemeMode.system:
        if (Get.isDarkMode) {
          Get.changeTheme(lightTheme);
          themeColor = _lightColor;
        } else {
          Get.changeTheme(_darkTheme);
          themeColor = _darkColor;
        }
        break;
      case ThemeMode.dark:
        Get.changeTheme(_darkTheme);
        themeColor = _darkColor;
        break;
      case ThemeMode.light:
        Get.changeTheme(lightTheme);
        themeColor = _lightColor;
        break;
    }
    Get.forceAppUpdate();
  }
}
