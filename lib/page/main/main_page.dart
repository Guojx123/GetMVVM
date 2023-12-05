import 'package:flutter/material.dart';
import 'package:flutterdemo/mvvm/base/base_state.dart';
import 'package:flutterdemo/page/main/controller/main_controller.dart';
import 'package:flutterdemo/theme/app_theme.dart';
import 'package:flutterdemo/util/extension/extension_util.dart';
import 'package:flutterdemo/util/extension/widget_extension.dart';
import 'package:flutterdemo/widget/base/base_scaffold.dart';
import 'package:flutterdemo/widget/common/common_app_bar.dart';
import 'package:flutterdemo/widget/text/text_common.dart';
import 'package:get/get.dart';

class MainPage extends BaseState<MainController> {
  @override
  Widget initView(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.white,
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
            color: Colors.red,
          ).addClickEvent(
            () async {
              AppTheme.changeThemeMode();
              await Get.forceAppUpdate();
            },
          ),
          GetBuilder<MainController>(
            builder: (logic) {
              return TextCommon(
                controller.bean?.token ?? "",
                maxLines: 10,
              );
            },
            id: "token",
          ),
          GetBuilder<MainController>(
            builder: (logic) {
              return TextCommon(controller.bean?.expire ?? "");
            },
            id: "time",
          ),
        ],
      ),
    );
  }

  @override
  MainController initController() => MainController();
}
