import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ToastUtil {
  static void showWidgetDialog(Widget widget) {
    SmartDialog.show(builder: (BuildContext context) => widget);
  }

  static void showSuccess(String msg) {
    SmartDialog.showToast(msg);
  }

  static void showFailed(String msg) {
    SmartDialog.showToast(msg);
  }

  static void showTips(String msg) {
    SmartDialog.showToast(msg);
  }
}
