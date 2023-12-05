import 'package:flutter/material.dart';

/// 品牌蓝

const primary_blue_color = Color(0xFF5F8BD5);

const primary_blue_color_end = Color(0xFF5F8BD5);

const primary_blue_color_start = Color(0xFF88B7EC);

/// 品牌红

const primary_red_color = Color(0xFFE85F5F);

const primary_red_color_end = Color(0xFFE85F5F);

const primary_red_color_start = Color(0xFFFF776E);

/// 辅助色

const telephonics_color = Color(0xFF3EC47C); // 通话语音

const select_button_color = Color(0xFFE1EDFF); // 选中按钮色

const notice_tab_color = Color(0xFFFFF9EF); // 通知提示栏

const price_button_color = Color(0xFFFFEBEB); // 金额按钮选择色

const tips_color = Color(0xFFEE6663); // 提示选择色

/// 文案色

const main_text_color = Color(0xFF333333); // 主文案

const main_text_color_white = Color(0xFFFFFFFF); // 主文案-白色

const second_text_color = Color(0xFF666666); // 副文案

const comment_text_color = Color(0xFF999999); // 注释

const divider_color = Color(0xFFCCCCCC); // 分割线

const step_color = Color(0xff979796); // 分割线

const divider_color_white = Color(0xFFEEEEEE); // 分割线

const warning_color = Color(0xFFDD3F3F); // 价格

/// 背景
const common_background = Color(0xFFF8F8F8); // 灰色背景

const common_background_gray = Color(0xFFEBEBEB); // 灰色背景

const common_background_red = Color(0xFFFFEBEB); // 红色背景

const common_background_white = Color(0xFFFFFFFF); // 纯白背景

const common_background_black = Color(0xFF000000); // 纯黑背景

const common_background_blue = Color(0xFFF8FAFC); // 纯灰背景

const primary_blue_color_backgroud = Color(0xFFF0F4FA);

const color_transparent = Color(0x00000000); // 透明

const color_shadow = Color(0xFFE0E0E0); // 阴影

const common_background_gray_f3 = Color(0xFFF3F3F3); // 灰色背景

const barrier_color = Color(0x885F5F5F); // 遮罩 -60%

/// 标签
const color_tag_cure = Color(0xFFA093DB); // 紫色 其他-other

const color_tag_orchid = Color(0xFF85BED5); // 兰色 起名择日-helpNamed
const color_tag_e8 = Color(0xFFE8F1FF); // 兰色

const color_tag_red = Color(0xFFEB7070); // 红色 解惑-answers

const color_tag_green = Color(0xFF8CBD90); // 绿色 新客体验-newGuest

const color_tag_blue = Color(0xFFE1EDFF); // 蓝色

const color_tag_orange = Color(0xFFFFB944); // 橙色
const color_tag_f9 = Color(0xFFFFF9EF); // 橙色

/// 大师等级
const color_master_intermediat = Color(0xFF4E829B); // 中级
const color_master_advanced = Color(0xFF54719F); // 高级
const color_master_senior = Color(0xFF854A85); // 资深
const color_master_expert = Color(0xFFDA9420); // 专家
const color_master_imperial = Color(0xFFBE2B00); // 御用

/// 聊天室
const color_blue_tips = Color(0xFFEDF3FD); // 提示背景色-蓝
const color_red_tips = Color(0xFFFFEEEE); // 提示背景色-红

// 规范还未完全，等规范确认之后修改色值（抽取变量）
class AskTheme {
  static LinearGradient common_gradient_blue = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary_blue_color_start, primary_blue_color_end],
  );

  static LinearGradient common_gradient_red = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary_red_color_start, primary_red_color_end],
  );

  static final LinearGradient common_disable_gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primary_blue_color_start.withOpacity(0.6),
      primary_blue_color_end.withOpacity(0.6)
    ],
  );

  static final common_decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    gradient: common_gradient_blue,
  );

  static final common_decoration_red = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    gradient: common_gradient_red,
  );

  static final common_decoration_disable = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    gradient: common_disable_gradient,
  );

  static final common_decoration_border_blue = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: primary_blue_color_end),
  );

  static final common_decoration_border_disable_blue = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: primary_blue_color_start),
  );

  static final common_decoration_border_red = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: primary_red_color_end),
  );

  static final common_decoration_border_disable_red = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: primary_red_color_start),
  );

  static final common_decoration_border = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: primary_blue_color_end),
  );

  // 规范还未完全，等规范确认之后修改色值（抽取变量）
  static final common_decoration_border_disable = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: const Color(0xff81C3FC)),
  );

  /// 灰色边框
  static final common_decoration_border_grey = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 1, color: divider_color),
  );

  static const common_fontweight_regular = FontWeight.normal;
  static const common_fontweight_medium = FontWeight.w500;
  static const common_fontweight_semibold = FontWeight.w600;
  static const common_fontweight_bold = FontWeight.bold;

  // 常用边框
  static Widget itemDivider({
    double? height,
    Color? color,
    double? thickness,
    double? indent,
    double? endIndent,
  }) {
    return Divider(
      height: height ?? 0.5,
      color: color ?? divider_color_white,
      thickness: thickness ?? 0.5,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
    );
  }

  // 输入框样式
  static InputDecoration commonInputDecoration(
    String hintText, {
    Widget? suffixWidget,
    bool hasSuffix = false,
  }) {
    return InputDecoration(
      hintStyle: const TextStyle(
        color: comment_text_color,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      suffix: hasSuffix ? suffixWidget : null,
      hintText: hintText,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      counterText: '',
      isDense: true,
    );
  }
}
