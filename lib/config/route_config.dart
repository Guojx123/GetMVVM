import 'package:flutterdemo/page/main/main_page.dart';
import 'package:flutterdemo/util/log.dart';
import 'package:get/get.dart';

enum RouteName {
  OrderHistoryPage,
}

class RouteConfig {
  // 主页
  static const String main = "/";

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () {
        int index = 0;
        try {
          index = int.parse(Get.parameters['index'] ?? "0");
        } catch (e) {
          Log.v("跳转聊天页异常");
        }
        return MainPage(index: index);
      },
    ),
  ];
}
