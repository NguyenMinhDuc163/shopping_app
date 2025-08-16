import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_dimension.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class TextInputCustom extends StatefulWidget {
  const TextInputCustom({
    super.key,
    this.label,
    required this.controller,
    this.fillColor = false,
    this.isLineBottom = true,
    this.isPassword = false,
    this.hintText = "",
    this.suffixIcon,
    this.titleStyle,
    this.validator,
    this.onTapOutside,
    this.onEditingComplete,
    this.onChanged,
    this.borderRadius,
    this.maxLines,
  });
  final String? label;
  final TextEditingController controller;
  final bool? fillColor;
  final int? maxLines;
  final String? hintText;
  final TextStyle? titleStyle;
  final bool Function(String)? validator;
  final bool isLineBottom;
  final bool isPassword;
  final Widget? suffixIcon;
  final BorderRadius? borderRadius;
  final void Function()? onTapOutside;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;

  @override
  State<TextInputCustom> createState() => _TextInputCustomState();
}

class _TextInputCustomState extends State<TextInputCustom> {
  bool isValid = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validate);
    obscureText = widget.isPassword;
  }

  void _validate() {
    if (widget.validator != null) {
      setState(() {
        isValid = widget.validator!(widget.controller.text);
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Text(
          widget.label ?? "",
          style:
              widget.titleStyle ??
              AppTextStyles.textContent3.copyWith(color: AppColors.coolGray),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? obscureText : false,
          maxLines: widget.maxLines,
          onTapOutside:
              (widget.onTapOutside != null)
                  ? (_) => widget.onTapOutside?.call()
                  : null,
          onEditingComplete:
              (widget.onEditingComplete != null)
                  ? widget.onEditingComplete
                  : null,
          onChanged: (widget.onChanged != null) ? widget.onChanged : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.inputHintText.copyWith(
              color: AppColors.coolGray,
            ),
            border:
                !widget.isLineBottom
                    ? InputBorder.none
                    : OutlineInputBorder(
                      borderRadius: widget.borderRadius ?? BorderRadius.zero,
                    ),
            filled: widget.fillColor,
            fillColor: AppColors.lightGray,
            suffix: _buildSuffixIcon(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isValid ? AppColors.limeGreen : AppColors.silverGray,
                width: 1,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.zero,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.silverGray, width: 1),
              borderRadius: widget.borderRadius ?? BorderRadius.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      );
    } else if (isValid && widget.suffixIcon != null) {
      return widget.suffixIcon;
    } else if (isValid) {
      return const Icon(Icons.done, color: Colors.green);
    }

    return null;
  }
}
