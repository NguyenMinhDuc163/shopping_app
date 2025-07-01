
import 'package:flutter/widgets.dart';

class WillUnfocusFormScope extends StatelessWidget {
  const WillUnfocusFormScope({
    super.key,
    required this.child,
    this.willUnfocusCallback,
  });

  final Widget child;
  final VoidCallback? willUnfocusCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        willUnfocusCallback?.call();
      },
      child: child,
    );
  }
}
