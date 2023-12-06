import 'package:flutter/material.dart';
import 'package:flutterdemo/mvvm/base/base_controller.dart';
import 'package:get/get.dart';

abstract class BaseView<BC extends BaseController> extends GetView<BC> {
  BaseView() {
    _initState(Get.context!);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BC>(
      initState: (controller) {
        debugPrint("koma===initState");
      },
      builder: (controller) {
        return _initView(context);
      },
    );
  }

  /// 父类初始化一些数据
  void _initState(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstFrameLayout(context));
    initControllers().forEach((element) {
      Get.lazyPut(() => element);
    });
    Get.put(initController()); // 初始化控制器
  }

  /// 初始化一些数据
  void initState(BindElement<BC> state) {}

  /// 初始化View
  Widget _initView(BuildContext context);

  /// 初始化ViewModel
  BC initController();

  /// 第一帧绘制完毕后
  /// Does *not* request a new frame.
  void afterFirstFrameLayout(BuildContext context) {}

  /// 如果当前页面不止一个controller的话，可以用数组来初始化
  List<GetxController> initControllers() {
    return [];
  }
}
