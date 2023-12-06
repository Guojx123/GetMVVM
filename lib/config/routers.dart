import 'package:flutterdemo/page/main/main_page.dart';
import 'package:flutterdemo/page/splash_page.dart';
import 'package:flutterdemo/util/log.dart';
import 'package:get/get.dart';

class Routers {
  /// 页面名称
  // 引导页
  static const String splash = "/splash";
  // 主页
  static const String main = "/main";
  // 登录页
  static const String login = "/login";
  // 设置页
  static const String setting = "/setting";

  /// 别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => SplashPage()),
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
    // GetPage(name: login, page: () => LoginPage()),
  ];
}
