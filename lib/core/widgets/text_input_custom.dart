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
    this.padding,
    this.fillColor = false,
    this.isLineBottom = true,
    this.isPassword = false,
    this.hintText = "",
    this.suffixIcon,
    this.titleStyle, this.validator,
  });
  final String? label;
  final TextEditingController controller ;
  final EdgeInsetsGeometry? padding;
final bool? fillColor;
  final String? hintText;
  final TextStyle? titleStyle;
  final bool Function(String)? validator;
  final bool isLineBottom;
  final bool isPassword;
  final Widget? suffixIcon;

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
    return Padding(
      padding: widget.padding  ?? AppPad.h22v10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ?? "",
            style:
            widget.titleStyle ??
                AppTextStyles.textContent3.copyWith(color: AppColors.coolGray),
          ),
          SizedBox(height: height_4,),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.inputHintText.copyWith(
                color: AppColors.coolGray,
              ),
              border: !widget.isLineBottom ? InputBorder.none :null,
              filled: widget.fillColor,
              fillColor: AppColors.lightGray,
              suffix: _buildSuffixIcon(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: isValid ? AppColors.limeGreen : AppColors.silverGray , width: 2),
              ),
            ),
          ),
        ],
      ),
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
    } else if (isValid) {
      return const Icon(Icons.done, color: Colors.green);
    } else if(widget.suffixIcon  != null){
      return widget.suffixIcon;
    }
    return null;
  }
}

