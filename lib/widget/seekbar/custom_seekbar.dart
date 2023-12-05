import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/widget/seekbar/get_text_width.dart';
import 'package:flutterdemo/widget/seekbar/progress_value.dart';
import 'package:flutterdemo/widget/seekbar/section_text_model.dart';

abstract class BasicSeekbar extends StatefulWidget {
  ///最小值
  final double min;

  ///最大值
  final double max;

  ///进度值
  final double value;

  /// 高度
  final double progressHeight;

  /// 总共分几份
  final int sectionCount;

  ///间隔圆圈的颜色
  final Color sectionColor;

  ///间隔圆圈未选中的颜色
  final Color sectionUnSelectColor;

  ///间隔圆圈的半径
  final double sectionRadius;

  ///显示间隔刻度值与否，默认是不显示
  final bool showSectionText;

  /// 刻度值的数组
  final List<SectionTextModel> sectionTexts;

  ///刻度值的字体大小
  final double sectionTextSize;

  /// 是否在拖拽结束显示值
  final bool? afterDragShowSectionText;

  ///刻度值的字体颜色
  final Color sectionTextColor;

  ///刻度值的字体颜色
  final Color sectionSelectTextColor;

  ///刻度值的小数点的位数，默认是0位
  final int? sectionDecimal;

  ///刻度值距离进度条的间距
  final double? sectionTextMarginTop;

  /// 指示器的半径
  final double indicatorRadius;

  ///指示器的颜色
  final Color indicatorColor;

  ///进度条背景的颜色
  final Color backgroundColor;

  /// 进度条当前进度的颜色
  final Color progressColor;

  ///进度改变的回调
  final ValueChanged<ProgressValue> onValueChanged;

  ///进度条是否是圆角的，还是方形的，默认是圆角的
  final bool isRound;

  const BasicSeekbar(
      {super.key,
      required this.min,
      required this.max,
      required this.value,
      required this.progressHeight,
      required this.sectionCount,
      required this.sectionColor,
      required this.sectionUnSelectColor,
      required this.sectionRadius,
      required this.showSectionText,
      required this.sectionTexts,
      required this.sectionTextSize,
      this.afterDragShowSectionText,
      required this.sectionTextColor,
      required this.sectionSelectTextColor,
      this.sectionDecimal,
      this.sectionTextMarginTop,
      required this.indicatorRadius,
      required this.indicatorColor,
      required this.backgroundColor,
      required this.progressColor,
      required this.onValueChanged,
      this.isRound = true});

  Color _getBackgroundColor(BuildContext context) => backgroundColor;

  Color _getProgressColor(BuildContext context) => progressColor;

  Widget _buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    return child;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value,
        showName: false, ifNull: '<indeterminate>'));
  }
}

class _SeekBarPainter extends CustomPainter {
  ///背景颜色
  final Color backgroundColor;

  ///进度条的颜色
  final Color progressColor;

  ///进度值
  final double value;

  ///最大值
  final double min;

  ///最小值
  final double max;

  ///指示器的半径，进度条右侧的原点
  double indicatorRadius;

  ///最外层的圆角
  double radius;

  ///间隔数量
  int sectionCount;

  ///间隔圆圈的颜色
  Color sectionColor;

  ///间隔圆圈未选中的颜色
  final Color sectionUnSelecteColor;

  ///间隔圆圈的半径
  double sectionRadius;

  ///显示间隔刻度值与否，默认是不显示
  final bool showSectionText;

  /// 刻度值的数组
  final List<SectionTextModel> sectionTexts;

  ///刻度值的字体大小
  final double sectionTextSize;
  final bool afterDragShowSectionText;

  ///刻度值的字体颜色
  final Color sectionTextColor;

  ///刻度值的字体颜色
  final Color sectionSelectTextColor;

  ///刻度值的小数点的位数，默认是0位
  final int sectionDecimal;

  ///刻度值距离进度条的间距
  final double sectionTextMarginTop;

  ///进度条的高度
  double progressHeight;

  ///指示器的颜色
  Color indicatorColor;

  _SeekBarPainter({
    required this.backgroundColor,
    required this.progressColor,
    required this.value,
    required this.min,
    required this.max,
    required this.sectionUnSelecteColor,
    required this.showSectionText,
    required this.sectionTexts,
    required this.sectionTextSize,
    required this.afterDragShowSectionText,
    required this.sectionTextColor,
    required this.sectionSelectTextColor,
    required this.sectionDecimal,
    required this.sectionTextMarginTop,
    this.indicatorRadius = 10,
    this.radius = 10,
    this.sectionCount = 4,
    this.sectionColor = Colors.green,
    this.sectionRadius = 10,
    this.progressHeight = 10,
    this.indicatorColor = Colors.red,
  });

  // 画path
  Path drawPath(double progressHeight, double x, double totalHeight, double r) {
    final Path path = Path();
    //如果间隔存在，而且半径大于0，而且如果进度条的高度大于间隔的直径，半径就取高度的，否则进度条会变形
    double R = r;
    if (sectionCount > 1 && sectionRadius > 0.0) {
      if (progressHeight > r * 2) {
        R = progressHeight;
      } else {
        R = 0.0;
      }
    }
    double startY = 0.0;
    double endY = progressHeight;
    startY = (-progressHeight + totalHeight) / 2;
    endY = (progressHeight + totalHeight) / 2;
    // if (progressHeight <= indicatorRadius) {
    //   startY = indicatorRadius - progressHeight / 2;
    //   endY = indicatorRadius + progressHeight / 2;
    // }
    if (r == null || r == 0.0) {
      path
        ..moveTo(0.0, startY)
        ..lineTo(x, startY)
        ..lineTo(x, endY)
        ..lineTo(0.0, endY);
    } else {
      path
        ..moveTo(R, startY)
        ..lineTo(x - R, startY)
        ..arcToPoint(Offset(x - R, endY), radius: Radius.circular(R))
        ..lineTo(R, endY)
        ..arcToPoint(Offset(R, startY),
            radius: Radius.circular(R), largeArc: true);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    ///1、画刻度值
    void drawSectionText() {
      if (!showSectionText) return;
      double yPosition = sectionTextMarginTop; //sectionTextMarginTop
      if (progressHeight > 2 * indicatorRadius) {
        yPosition += (progressHeight + size.height) / 2;
      } else {
        yPosition += indicatorRadius + size.height / 2;
      }
      final double e = (max - min) / sectionCount;

      for (var i = 0; i < sectionCount + 1; i++) {
        String point = (e * i + min).toStringAsFixed(sectionDecimal);

        if (sectionTexts.isNotEmpty) {
          final Iterable<SectionTextModel> match = sectionTexts.where((item) {
            return item.position == i;
          });

          if (match.isNotEmpty) {
            final SectionTextModel matchModel = match.first;
            point = matchModel.text;
          } else if (i == value * sectionCount &&
              afterDragShowSectionText != null &&
              afterDragShowSectionText) {
          } else {
            point = '';
          }
        }

        final Size textSize =
            getTextWidth(text: point, fontSize: sectionTextSize);
        Color textColor = sectionTextColor;
        if (sectionSelectTextColor != Colors.transparent &&
            i == value * sectionCount) {
          textColor = sectionSelectTextColor;
        }
        //为了计算文字和size的偏差
        double th = 0;
        if (textSize.height > size.height) {
          th = -(textSize.height - size.height) / 2;
        }
        canvas.drawParagraph(
            getParagraph(
                text: point,
                fontSize: 20,
                textColor: textColor,
                textSize: textSize),
            Offset(i * size.width / sectionCount - textSize.width / 2,
                yPosition + th));
      }
    }

    canvas.drawPath(
        drawPath(progressHeight, size.width, size.height, radius), paint); //画背景
    //下面是画矩形
    // Size newSize =  Size(size.width - indicatorRadius, size.height);
    // canvas.drawRect(Offset.zero & newSize, paint);

    paint.color = progressColor;

    // 画进度条
    void drawBar(double x, double progress) {
      if (x <= 0.0) return;
      //如果是分段，而且有自定义的刻度值
      if (sectionCount > 1 && sectionTexts.length > 1) {
        sectionTexts.forEach((item) {
          if (progress * sectionCount >= item.position) {
            if (item.progressColor != null) {
              paint.color = indicatorColor = sectionColor = item.progressColor;
            }
          }
        });
      }

      canvas.drawPath(drawPath(progressHeight, x, size.height, radius), paint);
      // canvas.drawRect(Offset(x, 0.0) & Size(width, size.height), paint);
    }

    //画间隔
    void drawInterval() {
      if (sectionCount <= 1) return;
      for (var i = 0; i < sectionCount + 1; i++) {
        paint.color =
            i > value * sectionCount ? sectionUnSelecteColor : sectionColor;

        canvas.drawCircle(
            Offset(i * size.width / sectionCount, size.height / 2),
            sectionRadius,
            paint);
      }
    }

    // 画当前显示的值的指示器
    void drawIndicator() {
      if (indicatorRadius <= 0.0) return;
      final Paint indicatorPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = indicatorColor;
      canvas.drawCircle(Offset(value * size.width, size.height / 2),
          indicatorRadius, indicatorPaint);
    }

    drawSectionText(); // draw section text 画刻度值

    drawBar(value.clamp(0.0, 1.0) * size.width, value); //画进度
    drawInterval(); //画间隔

    drawIndicator(); //draw indicator
  }

  @override
  bool shouldRepaint(_SeekBarPainter oldPainter) {
    return oldPainter != this;
  }
}

class SeekBar extends BasicSeekbar {
  const SeekBar({
    required ValueChanged<ProgressValue> onValueChanged,
    double min = 0.0,
    double max = 100.0,
    double progressHeight = 10,
    double value = 0.0,
    Color backgroundColor = Colors.black,
    Color progressColor = Colors.green,
    double indicatorRadius = 10,
    Color indicatorColor = Colors.black,
    int sectionCount = 4,
    Color sectionColor = Colors.black12,

    ///间隔圆圈未选中的颜色
    final Color sectionUnSelectColor = Colors.black26,
    double sectionRadius = 10,
    bool showSectionText = false,

    /// 刻度值的数组
    final List<SectionTextModel> sectionTexts = const [],

    ///刻度值的字体大小
    final double sectionTextSize = 14.0,
    bool afterDragShowSectionText = false,

    ///刻度值的字体颜色
    final Color sectionTextColor = Colors.red,

    ///刻度值的字体颜色
    final Color sectionSelectTextColor = Colors.pink,

    ///刻度值的小数点的位数，默认是0位
    final int sectionDecimal = 0,

    ///刻度值距离进度条的间距
    final double sectionTextMarginTop = 4.0,
    bool isRound = true,
  }) : super(
          onValueChanged: onValueChanged,
          min: min,
          max: max,
          progressHeight: progressHeight,
          value: value,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          indicatorRadius: indicatorRadius,
          indicatorColor: indicatorColor,
          isRound: isRound,
          sectionCount: sectionCount,
          sectionColor: sectionColor,
          sectionUnSelectColor: sectionUnSelectColor,
          sectionRadius: sectionRadius,
          showSectionText: showSectionText,
          sectionTexts: sectionTexts,
          sectionTextSize: sectionTextSize,
          afterDragShowSectionText: afterDragShowSectionText,
          sectionTextColor: sectionTextColor,
          sectionSelectTextColor: sectionSelectTextColor,
          sectionDecimal: sectionDecimal,
          sectionTextMarginTop: sectionTextMarginTop,
        );

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  ///进度值
  double _value = 0;
  bool? _afterDragShowSectionText;

  ///高度
  double? progressHeight;

  ///��高度
  double? totalHeight;

  ///中间的指示器的圆角
  double? indicatorRadius;

  ///左右两侧的圆角
  bool? isRound;

  ///间�����
  int sectionCount = 4;

  ///间隔圆圈的颜色
  Color? sectionColor;

  ///间隔圆圈未选中的颜色
  Color? sectionUnSelectColor;

  ///间隔圆圈的半径
  double? sectionRadius;

  ///气泡的总高度
  double? bubbleHeight;
  double length = 1;
  double e = 1;
  double start = 1;
  double end = 1;
  Offset touchPoint = Offset.zero;
  ProgressValue? v;

  @override
  void initState() {
    super.initState();
    _value = (widget.value - widget.min) / (widget.max - widget.min);
    progressHeight = widget.progressHeight;
    indicatorRadius = widget.indicatorRadius;
    sectionCount = widget.sectionCount;
    sectionRadius = widget.sectionRadius;
    _afterDragShowSectionText = false;
    if (sectionCount > 1) {
      e = 1 / sectionCount; //每一份的值
      start = 0.0;
      end = 0.0;
    }
    if ((indicatorRadius ?? 10) >= (progressHeight ?? 10)) {
      totalHeight = (indicatorRadius ?? 10) * 2;
    } else {
      totalHeight = progressHeight;
    }
    length = widget.max - widget.min;
  }

  Widget _buildSeekBar(
      BuildContext context, double value, double min, double max) {
    return widget._buildSemanticsWrapper(
      context: context,
      child: Container(
        // height: totalHeight,
        //下面的可以设置约束
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: 10,
        ),
        child: CustomPaint(
          painter: _SeekBarPainter(
            backgroundColor: widget._getBackgroundColor(context),
            progressColor: widget._getProgressColor(context),
            value: value,
            min: min,
            max: max,
            indicatorRadius: indicatorRadius ?? 10,
            progressHeight: progressHeight ?? 15,
            radius: widget.isRound ? (progressHeight ?? 15) / 2 : 0.0,
            indicatorColor: widget.indicatorColor,
            sectionCount: sectionCount,
            sectionColor: widget.sectionColor,
            sectionUnSelecteColor: widget.sectionUnSelectColor,
            sectionRadius: sectionRadius ?? 10,
            showSectionText: widget.showSectionText,
            sectionTexts: widget.sectionTexts,
            sectionTextSize: widget.sectionTextSize,
            afterDragShowSectionText: _afterDragShowSectionText ?? false,
            sectionTextColor: widget.sectionTextColor,
            sectionSelectTextColor: widget.sectionSelectTextColor,
            sectionDecimal: widget.sectionDecimal ?? 0,
            sectionTextMarginTop: widget.sectionTextMarginTop ?? 10,
          ),
        ),
      ),
    );
  }

  // Updates height and value when user taps on the SeekBar.
  void _onTapUp(TapUpDetails tapDetails) {
    setState(() {
      touchPoint = Offset(tapDetails.localPosition.dx, 0.0);
      _value = touchPoint.dx / context.size!.width;
      _setValue();

      if (widget.afterDragShowSectionText ?? false) {
        _afterDragShowSectionText = true;
      }
    });
  }

  void _onPanDown(DragDownDetails details) {
    touchPoint = details.localPosition;
    //防止绘画越界
    if (touchPoint.dx <= 0) {
      touchPoint = Offset(0, 0.0);
    }
    if (touchPoint.dx >= context.size!.width) {
      touchPoint = Offset(context.size!.width, 0);
    }
    if (touchPoint.dy <= 0) {
      touchPoint = Offset(touchPoint.dx, 0.0);
    }
    if (touchPoint.dy >= context.size!.height) {
      touchPoint = Offset(touchPoint.dx, context.size!.height);
    }
    setState(() {
      _value = touchPoint.dx / context.size!.width;
      _setValue();
      if (widget.afterDragShowSectionText ?? false) {
        _afterDragShowSectionText = false;
      }
    });
  }

  // Updates height and value when user drags the SeekBar.
  void _onPanUpdate(DragUpdateDetails dragDetails) {
    touchPoint = dragDetails.localPosition;
    //防止绘画越界
    if (touchPoint.dx <= 0) {
      touchPoint = Offset(0, 0.0);
    }
    if (touchPoint.dx >= context.size!.width) {
      touchPoint = Offset(context.size!.width, 0);
    }
    if (touchPoint.dy <= 0) {
      touchPoint = Offset(touchPoint.dx, 0.0);
    }
    if (touchPoint.dy >= context.size!.height) {
      touchPoint = Offset(touchPoint.dx, context.size!.height);
    }
    setState(() {
      _value = touchPoint.dx / context.size!.width;

      _setValue();
    });
  }

  void _onPanEnd(DragEndDetails dragDetails) {
    setState(() {
      if (widget.afterDragShowSectionText ?? false) {
        _afterDragShowSectionText = true;
      }
    });
  }

  void _setValue() {
    if (sectionCount > 1) {
      for (var i = 0; i < sectionCount; i++) {
        if (_value >= i * e && _value <= (i + 1) * e) {
          start = i * e;
          if (i == sectionCount) {
            end = sectionCount * e;
          } else {
            end = (i + 1) * e;
          }
          break;
        }
      }
      // if (_value >= start + e / 2) {
      //   _value = end;
      // } else {
      //   _value = start;
      // }
    }
    final double realValue = length * _value + widget.min; //真实的值

    if (widget.onValueChanged != null) {
      final ProgressValue v = ProgressValue(progress: _value, value: realValue);
      widget.onValueChanged(v);
    }
  }

  @override
  void didUpdateWidget(SeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _value = (widget.value - widget.min) / (widget.max - widget.min);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanDown: _onPanDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onTapUp: _onTapUp,
        child: _buildSeekBar(context, _value, widget.min, widget.max));
  }
}
