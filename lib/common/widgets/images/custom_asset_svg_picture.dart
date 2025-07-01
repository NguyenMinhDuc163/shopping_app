import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAssetSvgPicture extends StatelessWidget {
  const CustomAssetSvgPicture(
    this.assetName, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  const CustomAssetSvgPicture.square(
    this.assetName, {
    super.key,
    this.color,
    required double dimension,
    this.fit = BoxFit.contain,
  })  : width = dimension,
        height = dimension;

  factory CustomAssetSvgPicture.conditionalSquare(
    bool condition,
    String assetNameOnTrue,
    String assetNameOnFalse, {
    Color? color,
    required double dimension,
    BoxFit fit = BoxFit.contain,
  }) {
    if (condition) {
      return CustomAssetSvgPicture.square(
        assetNameOnTrue,
        dimension: dimension,
        color: color,
        fit: fit,
      );
    }

    return CustomAssetSvgPicture.square(
      assetNameOnFalse,
      dimension: dimension,
      color: color,
      fit: fit,
    );
  }

  final String assetName;

  final Color? color;

  /// If specified, the width to use for the SVG.  If unspecified, the SVG
  /// will take the width of its parent.
  final double? width;

  /// If specified, the height to use for the SVG.  If unspecified, the SVG
  /// will take the height of its parent.
  final double? height;

  /// How to inscribe the picture into the space allocated during layout.
  /// The default is [BoxFit.contain].
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}

class AssetIconSvg extends StatelessWidget {
  const AssetIconSvg(
    this.assetName, {
    super.key,
    this.dimension,
    this.color,
    this.fit = BoxFit.contain,
  }) : _isSliver = false;

  const AssetIconSvg.sliver(
    this.assetName, {
    super.key,
    this.dimension,
    this.color,
    this.fit = BoxFit.contain,
  }) : _isSliver = true;

  final String assetName;

  final double? dimension;

  final Color? color;

  /// How to inscribe the picture into the space allocated during layout.
  /// The default is [BoxFit.contain].
  final BoxFit fit;

  final bool _isSliver;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (dimension == null) {
      child = CustomAssetSvgPicture(
        assetName,
        color: color,
        fit: fit,
      );
    } else {
      child = CustomAssetSvgPicture.square(
        assetName,
        dimension: dimension!,
        color: color,
        fit: fit,
      );
    }

    if (!_isSliver) return child;

    return SliverToBoxAdapter(child: child);
  }
}
