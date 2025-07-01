import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

// TODO: update Design Screen Width
const double _designScreenWidth = 1;
// TODO: update Design Screen Height
const double _designScreenHeight = 1;

extension MediaQueryExt on BuildContext {
  BuildContext get root => findAncestorStateOfType<State<WidgetsApp>>()!.context;

  FlutterView get flutterView => View.of(this);

  MediaQueryData get rootViewMediaQueryData => MediaQueryData.fromView(flutterView);

  // Used to get the device pixel ratio which is not adjusted by a package
  // that makes the app responsive like the `responsive_framework`.
  //
  // Its's the number of device pixels for each logical pixel.
  double get rootDevicePixelRatio => rootViewMediaQueryData.devicePixelRatio; // MediaQuery.devicePixelRatioOf(root);

  double get rootTextScaleFactor => flutterView.platformDispatcher.textScaleFactor;

  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  // ignore: deprecated_member_use
  double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

  double maxTextScaleFactor(double max) => min(textScaleFactor, max);

  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  TextScaler maxTextScaler(double max) => textScaler.clamp(maxScaleFactor: max);

  double textScalerForDimensions(double dimensions) => textScaler.scale(dimensions) / dimensions;

  /// Using when a child of [SafeArea] tries to get [MediaQueryData.padding.top].
  ///
  /// Typically, it's the child of a popup or dialog, ...
  double get rootPaddingTop => rootViewMediaQueryData.padding.top;

  /// Using when a child of [SafeArea] tries to get [MediaQueryData.padding.bottom].
  ///
  /// Typically, it's the child of a popup or dialog, ...
  double get rootPaddingBottom => rootViewMediaQueryData.padding.bottom;

  /// The parts of the display that are partially obscured by system UI,
  /// typically by the hardware display "notches" or the system status bar.
  double get viewPaddingTop => MediaQuery.viewPaddingOf(this).top;

  /// The parts of the display that are partially obscured by system UI,
  /// typically by the hardware display "notches" or the system status bar.
  double get viewPaddingBottom => MediaQuery.viewPaddingOf(this).bottom;

  bool get hasViewPaddingBottom => viewPaddingBottom != 0.0;

  /// Like Samsung Fold
  bool get isFoldableDevice {
    for (final d in MediaQuery.displayFeaturesOf(this)) {
      if (d.type == DisplayFeatureType.hinge) {
        return true;
      }
    }
    return false;
  }

  /// The proportion is maintained.
  Offset getResponsiveOffsetBaseOnWidth({
    required double topOffset,
    required double leftOffset,
    required double designScreenWidth,
  }) {
    final Size offsetBaseSize = getResponsiveSizeBaseOnWidth(
      designWidth: leftOffset,
      designHeight: topOffset,
      designScreenWidth: designScreenWidth,
    );

    return Offset(offsetBaseSize.width, offsetBaseSize.height);
  }

  /// Adjusts the size based on the screen width
  /// and maintains the aspect ratio.
  ///
  /// **Example 1:** screenWidth `>` designScreenWidth
  ///
  /// **Example 1.1:** design width `==` design height
  ///
  /// ```
  /// designWidth = 200
  /// designHeight = 200
  /// designScreenWidth = 375
  /// screenWidth = 816
  ///
  /// widthDelta = 200 / 375 = 0,533
  /// heightDelta = 200 / 200 = 1
  ///
  /// Size:
  ///  - Width = 816 * 0,533 = 435,2
  ///  - Height = 435,2 * 1 = 435,2
  /// ```
  ///
  /// **Example 1.2:** design width `>` design height
  ///
  /// ```
  /// designWidth = 500
  /// designHeight = 200
  /// designScreenWidth = 375
  /// screenWidth = 816
  ///
  /// widthDelta = 500 / 375 = 1,333
  /// heightDelta = 200 / 500 = 0,4
  ///
  /// Size:
  ///  - Width = 816 * 1,333 = 1088
  ///  - Height = 1088 * 0,4 = 435,2
  /// ```
  ///
  /// **Example 1.3:** design width `<` design height
  ///
  /// ```
  /// - designWidth = 200
  /// - designHeight = 500
  /// - designScreenWidth = 375
  /// - screenWidth = 816
  ///
  /// widthDelta = 200 / 375 = 0,533
  /// heightDelta = 500 / 200 = 2,5
  ///
  ///  - Width = 816 * 0,533 = 435,2
  ///  - Height = 435,2 * 2,5 = 1088
  /// ```
  /// 
  /// **Example 2:** screenWidth `<` designScreenWidth
  ///
  /// **Example 2.1:** design width `>` design height
  ///
  /// ```
  /// designWidth = 500
  /// designHeight = 200
  /// designScreenWidth = 428
  /// screenWidth = 375
  ///
  /// widthDelta = 500 / 428 = 1,168
  /// heightDelta = 200 / 500 = 0,4
  ///
  /// Size:
  ///  - Width = 375 * 1,168 = 438
  ///  - Height = 438 * 0,4 = 175,2
  /// ```
  ///
  /// **Example 2.2:** design width `<` design height
  ///
  /// ```
  /// designWidth = 750
  /// designHeight = 1334
  /// designScreenWidth = 428
  /// screenWidth = 375
  ///
  /// widthDelta = 750 / 428 = 1,7523
  /// heightDelta = 1334 / 750 = 1,7787
  ///
  /// Size:
  ///  - Width = 375 * 1,7523 = 657,1125
  ///  - Height = 657,1125 * 1,7787 = 1168,806
  /// ```
  Size getResponsiveSizeBaseOnWidth({
    required double designWidth,
    required double designHeight,
    required double designScreenWidth,

    /// When using the [DisplayFeatureSubScreen] widget, this calculation
    /// returns an incorrect Size because the max width is not the screen width.
    ///
    /// To obtain this value, use the [LayoutBuilder] widget and
    /// get its [constraints.maxWidth].
    double? layoutMaxWidth,
  }) {
    final double widthDelta = designWidth / designScreenWidth;
    double heightDelta = designHeight / designWidth;

    if (heightDelta.isNaN) {
      heightDelta = 0;
    } else if (heightDelta.isInfinite) {
      // (question?) 0 or 1
      heightDelta = 1;
    }

    final effectiveWidth = (layoutMaxWidth ?? screenWidth) * widthDelta;

    return Size(effectiveWidth, effectiveWidth * heightDelta);
  }

  /// The result of the calculation from the function
  /// [getResponsiveOffsetBaseOnWidth] compared to this function may have
  /// slight precision differences due to floating-point arithmetic,
  /// but the proportion is still maintained.
  ///
  /// **Example 1:** screenWidth `>` designScreenWidth
  ///
  /// **Example 1.1:** design width `==` design height
  ///
  /// ```
  /// designWidth = 200
  /// designHeight = 200
  /// designScreenWidth = 375
  /// screenWidth = 816
  ///
  /// widthDelta = 375 / 200 = 1,875
  /// width = 816 / 1,875 = 435,2
  /// ratio = 200 / 200 = 1
  ///
  /// Size:
  ///  - Width = 435,2
  ///  - Height = 435,2 / 1 = 435,2
  /// ```
  ///
  /// **Example 1.2:** design width `>` design height
  ///
  /// ```
  /// designWidth = 500
  /// designHeight = 200
  /// designScreenWidth = 375
  /// screenWidth = 816
  ///
  /// widthDelta = 375 / 500 = 0,75
  /// width = 816 / 0,75 = 1088
  /// ratio = 500 / 200 = 2,5
  ///
  /// Size:
  ///  - Width = 1.088
  ///  - Height = 1088 / 2,5 = 435,2
  /// ```
  ///
  /// **Example 1.3:** design width `<` design height
  ///
  /// ```
  /// - designWidth = 200
  /// - designHeight = 500
  /// - designScreenWidth = 375
  /// - screenWidth = 816
  ///
  /// widthDelta = 375 / 200 = 1,875
  /// width = 816 / 1,875 = 435,2
  /// ratio = 200 / 500 = 0,4
  ///
  ///  - Width = 435,2
  ///  - Height = 435,2 / 0,4 = 1088
  /// ```
  /// 
  /// **Example 2:** screenWidth `<` designScreenWidth
  ///            AND design width `>` design screen width
  ///
  /// **Example 2.1:** design width `>` design height
  ///
  /// ```
  /// designWidth = 500
  /// designHeight = 200
  /// designScreenWidth = 428
  /// screenWidth = 375
  ///
  /// widthDelta = 428 / 500 = 0,856
  /// width = 375 / 0,856 = 438,084
  /// ratio = 500 / 200 = 2,5
  ///
  /// Size:
  ///  - Width = 438,084
  ///  - Height = 438,084 / 2,5 = 175,2336
  /// ```
  ///
  /// **Example 2.2:** design width `<` design height
  ///
  /// ```
  /// designWidth = 750
  /// designHeight = 1334
  /// designScreenWidth = 428
  /// screenWidth = 375
  ///
  /// widthDelta = 428 / 750 = 0,571
  /// width = 375 / 0,571 = 656,7426
  /// ratio = 750 / 1334 = 0,562
  ///
  /// Size:
  ///  - Width = 656,7426
  ///  - Height = 656,7426 / 0,562 = 1168,581
  /// ```
  Size getScaleSize({
    required double designWidth,
    required double designHeight,
    required double designScreenWidth,
  }) {
    final double widthDelta = designScreenWidth / designWidth;
    final double width = screenWidth / widthDelta;
    final double ratio = designWidth / designHeight;

    return Size(width, width / ratio);
  }

  double proportionateToScreenWidth(
    double designWidth, {
    double? designScreenWith,
  }) {
    final ratio = designWidth / (designScreenWith ?? _designScreenWidth);
    return screenWidth * ratio;
  }

  double proportionateToScreenHeight(
    double designHeight, {
    double? designScreenHeight,
  }) {
    final ratio = designHeight / (designScreenHeight ?? _designScreenHeight);
    return screenHeight * ratio;
  }

  /// Adjusts the size based on the screen width and screen height.
  /// The __aspect ratio__ of the design __won't be maintained__.
  ///
  /// **Example 1:** screenWidth `>` designScreenWidth
  ///
  /// **Example 1.1:** design width `==` design height
  ///
  /// ```
  /// designWidth = 200
  /// designHeight = 200
  /// designScreenWidth = 375
  /// designScreenHeight = 812
  /// screenWidth = 816
  /// screenHeight = 1056
  ///
  /// widthRatio = 200 / 375 = 0,533
  /// heightRatio = 200 / 812 = 0,2463
  ///
  /// Size:
  ///  - Width = 816 * 0,533 = 435,2
  ///  - Height = 1056 * 0,2463 = 260,0928
  /// ```
  Size proportionateToScreenSize(
    double designWidth,
    double designHeight, {
    double? designScreenWith,
    double? designScreenHeight,
  }) {
    return Size(
      proportionateToScreenWidth(designWidth, designScreenWith: designScreenWith),
      proportionateToScreenHeight(designWidth, designScreenHeight: designScreenHeight),
    );
  }
}

extension TextScalerExt on TextScaler {
  double forDimensions(double dimensions) => dimensions * scale(1);

  double operator *(double dimensions) => dimensions * scale(1);
}
