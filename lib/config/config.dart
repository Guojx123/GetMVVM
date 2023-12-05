import 'package:flutter/foundation.dart' as foundation;
import 'package:flutterdemo/config/EnvConfig.dart';

class Config {
  /// 当前是否是debug模式
  static bool isDebug =
      foundation.kDebugMode || EnvConfig.BUILD_TYPE == BuildType.dev.value;
}
