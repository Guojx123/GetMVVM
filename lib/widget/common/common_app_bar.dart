import 'package:flutter/material.dart';
import 'package:flutterdemo/theme/style.dart';
import 'package:flutterdemo/util/extension/extension_util.dart';
import 'package:get/get.dart';

//右侧按钮点击事件
typedef ActionTapCallback = void Function();
//返回按钮点击事件
typedef LeadingTapCallback = void Function();

const backButtonWidth = 24.0;
const backButtonHeight = 24.0;
const appBarHeight = 42.0;

//标题默认TextStyle
const _title_text_style = TextStyle(
  fontSize: 16.0,
  color: main_text_color,
  fontWeight: FontWeight.w500,
);

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  Color backgroundColor;
  TextStyle textStyle;
  double elevation;
  bool canBack;
  bool centerTitle;
  Widget? action;
  String? iconAsset;
  String? backAsset;
  double iconWidth;
  double iconHeight;
  EdgeInsets actionPadding;
  EdgeInsets? actionMargin;
  ActionTapCallback? onActionTap;
  LeadingTapCallback? onLeadingTap;
  PreferredSize? bottomWidget;
  String? package;
  double? leadingWidth;

  /// 使用说明
  /// * title为null时,默认赋值为""
  /// * textStyle会覆盖默认值
  CommonAppBar({
    Key? key,
    this.title = '',
    this.backgroundColor = common_background_white,
    this.textStyle = _title_text_style,
    this.elevation = 0.2,
    this.canBack = true,
    this.centerTitle = true,
    this.action,
    this.iconAsset,
    this.backAsset,
    this.iconWidth = backButtonWidth,
    this.iconHeight = backButtonHeight,
    this.actionPadding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.actionMargin,
    this.onActionTap,
    this.onLeadingTap,
    this.package,
    this.bottomWidget,
    this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        actions: [_buildAction()],
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        surfaceTintColor: common_background_white,
        centerTitle: centerTitle,
        elevation: elevation,
        leading: _buildLeading(context),
        leadingWidth: leadingWidth,
        title: Text(title, style: textStyle),
        bottom: bottomWidget,
      ),
    );
  }

  ///返回按钮
  Widget _buildLeading(BuildContext context) {
    return canBack
        ? GestureDetector(
            onTap: onLeadingTap ?? () => Get.back(),
            behavior: HitTestBehavior.translucent,
            child: (backAsset ?? "").isNullOrEmpty
                ? Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      backAsset!,
                      width: backButtonWidth,
                      height: backButtonHeight,
                    ),
                  ),
          )
        : Container();
  }

  ///右侧按钮
  Widget _buildAction() {
    if (action != null) {
      // 如果传入action, 又传入了onTap, 提供默认样式效果(点击效果,默认padding等)
      return onActionTap != null
          ? _generateAction(action!, onActionTap)
          : action!;
    } else if (iconAsset?.isNotEmpty == true) {
      // 生成icon Widget
      return _generateAction(
        Image.asset(iconAsset!,
            width: iconWidth, height: iconHeight, package: package),
        onActionTap,
      );
    }
    return Container();
  }

  Widget _generateAction(Widget child, ActionTapCallback? onActionTap) {
    return Container(
      margin: actionMargin,
      child: GestureDetector(
        onTap: onActionTap,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: actionPadding,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
