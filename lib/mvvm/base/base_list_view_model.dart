import 'package:flutterdemo/mvvm/base/base_controller.dart';

/// 基于
abstract class BaseListViewModel<T> extends BaseController {
  /// 页面数据
  List<T> list = [];

  // 第一次进入页面loading skeleton
  Future initData() async {
    setBusy();
    await refresh(init: true);
  }

  // 下拉刷新
  @override
  Future refresh({bool init = false}) async {
    try {
      final List<T> data = await loadData();
      if (data.isEmpty) {
        list.clear();
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        onCompleted(data);
        setIdle();
      }
    } catch (e, s) {
      if (init) list.clear();
      setError(e, s);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  void onCompleted(List<T> data);
}
