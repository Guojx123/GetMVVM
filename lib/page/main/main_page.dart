import 'package:flutter/material.dart';
import 'package:flutterdemo/mvvm/base/base_view.dart';
import 'package:flutterdemo/page/main/controller/main_controller.dart';
import 'package:flutterdemo/theme/app_theme.dart';
import 'package:flutterdemo/util/extension/extension_util.dart';
import 'package:flutterdemo/util/log.dart';
import 'package:flutterdemo/widget/base/base_scaffold.dart';
import 'package:flutterdemo/widget/common/common_app_bar.dart';
import 'package:flutterdemo/widget/text/text_common.dart';
import 'package:get/get.dart';

class MainPage extends BaseView<MainController> {
  final num? index;

  MainPage({this.index = 0});

  @override
  Widget build(BuildContext context) {
    // 返回视图的实现
    return BaseScaffold(
      isTwiceBack: true,
      appBar: CommonAppBar(
        title: "首页",
        canBack: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          100.heightBox,
          TextCommon(
            "text  Gino".tr,
            size: 20,
            color: Colors.pinkAccent,
          ).addClickEvent(
            () async {
              Log.d("测试");
              AppTheme.changeThemeMode();
            },
          ),
          TextCommon(
            "${index ?? 111}",
            color: Colors.cyanAccent,
          ).addClickEvent(
            () async {
              Log.d("测试");
              AppTheme.changeThemeMode();
            },
          ),
          TextCommon(
            controller.bean?.token ?? "",
            maxLines: 10,
          ),
          TextCommon(controller.bean?.expire ?? ""),
        ],
      ),
    );
  }

  @override
  MainController initController() {
    // 初始化控制器
    return MainController();
  }
}
