import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///
/// 通用网络图片加载组件
///

class CommonCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? radius;
  final Color? fgColor;
  final Widget? placeholder;
  final int? memCache;

  const CommonCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.radius,
    this.fgColor,
    this.placeholder,
    this.memCache,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) {
        return placeholder ?? _defaultPlaceHolder(width, height);
      },
      errorWidget: (context, url, error) {
        return _defaultPlaceHolder(width, height);
      },
      fit: fit ?? BoxFit.cover,
      memCacheHeight: memCache ?? 200,
      memCacheWidth: memCache ?? 200,
      filterQuality: FilterQuality.high,
      color: fgColor,
    );
  }

  Widget _defaultPlaceHolder(double? width, double? height) {
    return Image.asset(
      'assets/common/ic_default.png',
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
