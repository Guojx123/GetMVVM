import 'package:flutter/material.dart';
import 'package:flutterdemo/theme/style.dart';
import 'package:flutterdemo/widget/base/scroll_behavior.dart';
import 'package:get/get.dart';

typedef ClickCallback = void Function(Object value, String show);
typedef CancelCallback = void Function();

//如果有Hint，不需要展示的位置则传空串，如第二条需要展示则传["", "xxx"]
class CommonBottomSheet {
  static void showBottomSheet({
    required List<Object> values,
    required List<String> shows,
    required ClickCallback clickCallback,
    CancelCallback? cancelCallback,
    List<String>? hint,
    List<Color>? hintColor,
    List<Widget>? texts,
    Object? currentObject, //
    bool? isDismissible, // 最好传值String
    String? title,
  }) {
    assert(values.isNotEmpty && values.length == shows.length);
    if (hint != null) {
      assert(hint.length == shows.length);
    }
    if (texts != null) {
      assert(texts.length == shows.length);
    }
    var showLength = shows.length < 5 ? shows.length : 5;

    showLength = title != null ? showLength + 1 : showLength;

    Get.bottomSheet(
      Container(
        color: Colors.white,
        //固定展示5个
        constraints: BoxConstraints(
          maxHeight:
              72 + (56 + (hint != null ? 16 : 0)) * showLength.toDouble(),
        ),
        child: Column(
          children: [
            if (title != null)
              SizedBox(
                height: 54,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: main_text_color,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context).pop();
                        clickCallback(values[index], shows[index]);
                      },
                      child: SizedBox(
                        height: 48 + (hint != null ? 16 : 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (texts != null)
                              texts[index]
                            else
                              Text(
                                shows[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: currentObject != null &&
                                          currentObject == values[index]
                                      ? main_text_color
                                      : primary_blue_color,
                                ),
                              ),
                            if (hint != null && hint[index].isNotEmpty)
                              const SizedBox(
                                height: 6,
                              ),
                            if (hint != null && hint[index].isNotEmpty)
                              Text(
                                hint[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (hintColor != null)
                                      ? hintColor[index]
                                      : second_text_color,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AskTheme.itemDivider(
                    height: 0.5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  itemCount: shows.length,
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.back();
                cancelCallback?.call();
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: common_background,
                  borderRadius: BorderRadius.circular(25),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Center(
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                      color: primary_blue_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      isDismissible: isDismissible ?? true,
    );
  }
}
