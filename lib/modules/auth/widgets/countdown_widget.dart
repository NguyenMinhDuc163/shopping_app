import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class CountdownWidget extends StatefulWidget {
  final VoidCallback? onResend;
  final int seconds;

  const CountdownWidget({super.key, this.onResend, this.seconds = 20});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late int _seconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = widget.seconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          _seconds == 0
              ? () {
                _startTimer();
                if (widget.onResend != null) widget.onResend!();
              }
              : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')} ",
            style: AppTextStyles.textContent2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
