import 'package:flutterdemo/config/config.dart';

class AddressManager {
  AddressManager._();

  static final String BASE_URL =
      Config.isDebug ? "http://apitest.kd.net/" : "http://apitest.kd.net/";

  /// 登录
  static String login = "v1/login";
}
