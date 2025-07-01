import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/utils/ui/media_query_extension.dart';

import '../shimmer_wrapper.dart';

class ResponsiveCachedNetworkRectangleImage extends StatelessWidget {
  const ResponsiveCachedNetworkRectangleImage({
    super.key,
    required this.width,
    required this.height,
    this.designScreenWidth = 375,
    this.alignment = Alignment.center,
    required this.imageUrl,
    this.imageDecoration = const BoxDecoration(),
    this.errorWidget,
    this.fit,
  });

  final double width;
  final double height;
  final double designScreenWidth;

  final String imageUrl;
  final BoxDecoration imageDecoration;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = context.getResponsiveSizeBaseOnWidth(
      designWidth: width,
      designHeight: height,
      designScreenWidth: designScreenWidth,
    ) * context.textScaleFactor;

    return CachedNetworkRectangleImage(
      key: const Key('<CachedNetworkRectangleImageWrapper>'),
      width: effectiveHeight.width,
      height: effectiveHeight.height,
      alignment: alignment,
      imageUrl: imageUrl,
      imageDecoration: imageDecoration,
      errorWidget: errorWidget,
      fit: fit,
    );
  }
}

class CachedNetworkRectangleImage extends StatelessWidget {
  const CachedNetworkRectangleImage({
    super.key,
    this.width = double.infinity,
    this.height,
    this.minHeight,
    this.alignment = Alignment.center,
    required this.imageUrl,
    this.imageDecoration = const BoxDecoration(),
    this.applyClip = false,
    this.errorWidget,
    this.fit,
    this.onLoadSuccess,
    this.onLoadFailed,
    this.child,
  });

  final double? width;
  final double? height;
  final double? minHeight;

  final String imageUrl;
  final BoxDecoration imageDecoration;
  final bool applyClip;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Alignment alignment;

  final void Function(ImageProvider imageProvider)? onLoadSuccess;
  final VoidCallback? onLoadFailed;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: Key(imageUrl),
      imageUrl: imageUrl,
      height: height,
      width: width,
      alignment: alignment,
      fit: fit,
      progressIndicatorBuilder: (_, __, ___) {
        final Widget child;

        if (imageDecoration.borderRadius != null) {
          child = DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: imageDecoration.borderRadius,
            ),
          );
        } else {
          child = const ColoredBox(
            color: Colors.white,
          );
        }

        return ShimmerWrapper(
          child: SizedBox(
            height: height ?? minHeight,
            width: width,
            child: child,
          ),
        );
      },
      fadeInDuration: minHeight == null ? const Duration(milliseconds: 500) : const Duration(milliseconds: 800),
      fadeOutDuration: minHeight == null ? const Duration(milliseconds: 1000) : const Duration(milliseconds: 100),
      imageBuilder: (_, imageProvider) {
        onLoadSuccess?.call(imageProvider);

        if ((width == double.infinity || width == context.screenWidth) && height == null) {
          Widget image = Image(
            image: imageProvider,
            alignment: alignment,
            color: imageDecoration.color,
            colorBlendMode: BlendMode.srcATop,
            fit: fit,
          );

          if (imageDecoration.borderRadius != null) {
            image = ClipRRect(
              borderRadius: imageDecoration.borderRadius!,
              child: image,
            );
          }

          return image;
        }

        Widget? child = this.child;

        if (applyClip && imageDecoration.borderRadius != null) {
          child = ClipRRect(
            borderRadius: imageDecoration.borderRadius!,
            child: child,
          );
        }

        return SizedBox(
          height: height ?? minHeight,
          width: width ?? double.infinity,
          child: DecoratedBox(
            decoration: imageDecoration.copyWith(
              image: DecorationImage(
                image: imageProvider,
                alignment: alignment,
                fit: fit,
              ),
            ),
            child: child,
          ),
        );
      },
      errorWidget: errorWidget == null ? null : (_, __, ___) => errorWidget!,
      errorListener: onLoadFailed == null ? null : (exception) => onLoadFailed!(),
    );
  }
}

class CachedNetworkCircleImage extends StatelessWidget {
  const CachedNetworkCircleImage({
    super.key,
    required this.size,
    required this.imageUrl,
    this.imageDecoration = const BoxDecoration(),
    this.errorWidget,
  });

  final double size;
  final String imageUrl;
  final BoxDecoration imageDecoration;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: Key(imageUrl),
      imageUrl: imageUrl,
      height: size,
      width: size,
      progressIndicatorBuilder: (_, __, ___) => ShimmerWrapper(
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
      imageBuilder: (_, imageProvider) => SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: imageDecoration.copyWith(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      errorWidget: errorWidget == null ? null : (_, __, ___) => errorWidget!,
    );
  }
}
