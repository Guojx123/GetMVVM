import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutterdemo/theme/app_theme.dart';

typedef ScaffoldParamVoidCallback = void Function();

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    this.keyName,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.isTwiceBack = false,
    this.isCanBack = true,
    this.onBack,
    this.titleBarColor,
  })  : assert(primary != null),
        assert(extendBody != null),
        assert(extendBodyBehindAppBar != null),
        assert(drawerDragStartBehavior != null);

  ///系统Scaffold的属性
  final Key? keyName;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Color? titleBarColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;

  ///增加的属性
  ///点击返回按钮提示是否退出页面,快速点击俩次才会退出页面
  final bool isTwiceBack;

  ///是否可以返回
  final bool isCanBack;

  ///监听返回事件
  final ScaffoldParamVoidCallback? onBack;

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  DateTime? _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: dealWillPop,
      child: Scaffold(
        key: widget.keyName,
        appBar: widget.appBar ??
            AppBar(
              toolbarHeight: 0,
              backgroundColor:
                  widget.titleBarColor ?? AppTheme.themeColor.textPrimary,
              elevation: 0,
            ),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        backgroundColor:
            widget.backgroundColor ?? AppTheme.themeColor.textPrimary,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        drawerScrimColor: widget.drawerScrimColor,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      ),
    );
  }

  ///控件返回按钮
  Future<bool> dealWillPop() async {
    if (widget.onBack != null) {
      widget.onBack!();
    }
    final bool isExist = SmartDialog.config.checkExist();
    //处理弹窗问题
    if (isExist) {
      SmartDialog.dismiss();
      return false;
    }

    //如果不能返回，后面的逻辑就不走了
    if (!widget.isCanBack) {
      return false;
    }

    if (widget.isTwiceBack) {
      if (_lastPressedAt == null ||
          DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
        //两次点击间隔超过1秒则重新计时
        _lastPressedAt = DateTime.now();

        //弹窗提示
        SmartDialog.showToast("再点一次退出");
        return false;
      }
      return true;
    } else {
      return true;
    }
  }
}
