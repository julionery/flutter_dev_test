import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? labelText;
  final String? hintText;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      obscureText: _obscurePassword,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText && (widget.controller != null && widget.controller!.text.isNotEmpty)
                ? IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textOnBackground,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  )
                : null),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
