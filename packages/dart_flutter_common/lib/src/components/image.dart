import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageShape {
  circle,
  square,
  rectangle,
}

class GenericImageWidget extends StatelessWidget {
  const GenericImageWidget({
    required this.imageUrl,
    required this.imageShape,
    this.onTap,
    // 各図形の高さ。circle/squareの場合、widthにもこの値が入る。rectangleの場合、widthはこれの2倍の値が入る
    // 指定がない場合は、defaultとして64.0が入る
    this.height,
    this.radius,
    super.key,
  });

  final String imageUrl;
  final ImageShape imageShape;
  final VoidCallback? onTap;
  final double? height;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return imageUrl.isEmpty
        ? _ImageDisplayContainer(
            imageShape: imageShape,
            color: Colors.grey,
            height: height,
            radius: radius,
          )
        : GestureDetector(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) {
                return _ImageDisplayContainer(
                  imageShape: imageShape,
                  height: height,
                  radius: radius,
                  decorationImage: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                );
              },
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.broken_image),
              ),
            ),
          );
  }
}

class _ImageDisplayContainer extends StatelessWidget {
  const _ImageDisplayContainer({
    required this.imageShape,
    this.color,
    this.height,
    this.radius,
    this.decorationImage,
  });

  final ImageShape imageShape;
  final Color? color;
  final double? height;
  final double? radius;
  final DecorationImage? decorationImage;
  @override
  Widget build(BuildContext context) {
    const defaultSize = 64.0;

    // 長方形が指定された場合のみ、指定されたheightの2倍の値またはdefaulSizeの2倍の値をwidthに設定する
    // それ以外の場合は、指定されたheightの値またはdefaultSizeをwidthに設定する
    final adjustWidth = imageShape == ImageShape.rectangle
        ? (height != null ? height! * 2 : defaultSize * 2)
        : height ?? defaultSize;

    return Center(
      child: Container(
        height: height ?? defaultSize,
        width: adjustWidth,
        decoration: BoxDecoration(
          color: color,
          shape: imageShape == ImageShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: imageShape != ImageShape.circle
              ? BorderRadius.circular(radius ?? 0)
              : null,
          image: decorationImage,
        ),
      ),
    );
  }
}
