import 'package:flutter/material.dart';

class SwitchBottomWidget extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  const SwitchBottomWidget({Key? key, this.onChanged}) : super(key: key);

  @override
  State<SwitchBottomWidget> createState() => _SwitchBottomWidgetState();
}

// TODO didUpdateWidget
class _SwitchBottomWidgetState extends State<SwitchBottomWidget> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      activeColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey[300],
    );
  }
}