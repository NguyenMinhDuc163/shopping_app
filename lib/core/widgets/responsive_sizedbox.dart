import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopping_app/utils/ui/media_query_extension.dart';

class ResponsiveSizedbox extends SizedBox {
  const ResponsiveSizedbox({
    super.key,
    super.width,
    super.height,
    this.maxTextScaleFactor = 2,
    super.child,
  });

  final double maxTextScaleFactor;

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      additionalConstraints: _additionalConstraints * context.maxTextScaleFactor(maxTextScaleFactor),
    );
  }

  BoxConstraints get _additionalConstraints {
    return BoxConstraints.tightFor(width: width, height: height);
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = _additionalConstraints * context.maxTextScaleFactor(maxTextScaleFactor);
  }
}
