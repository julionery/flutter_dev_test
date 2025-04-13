import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/foundations/typography.dart';

const _kOtpSize = Size(52, 54);

class AppOTPTextField extends StatefulWidget {
  const AppOTPTextField({
    super.key,
    this.onChanged,
    this.value = '',
    this.enabled = true,
  });

  final ValueChanged<String>? onChanged;
  final String value;
  final bool enabled;

  @override
  State<AppOTPTextField> createState() => _AppOTPTextFieldState();
}

class _AppOTPTextFieldState extends State<AppOTPTextField> {
  final List<TextEditingController> _codeControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _updateControllersFromValue();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNodes.first.requestFocus();
    });
  }

  @override
  void didUpdateWidget(AppOTPTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _updateControllersFromValue();
    }
  }

  void _updateControllersFromValue() {
    final digits = widget.value.split('');

    for (var controller in _codeControllers) {
      controller.text = '';
    }

    for (int i = 0; i < digits.length && i < _codeControllers.length; i++) {
      _codeControllers[i].text = digits[i];
    }
  }

  @override
  void dispose() {
    for (final controller in _codeControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => Container(
          height: _kOtpSize.height,
          width: _kOtpSize.width,
          padding: EdgeInsets.all(AppSpacing.$25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),
          child: DigitField(
            controller: _codeControllers[index],
            focusNode: _focusNodes[index],
            nextFocusNode: index < 5 ? _focusNodes[index + 1] : null,
            previousFocusNode: index > 0 ? _focusNodes[index - 1] : null,
            textStyle: AppTypography.titleLarge,
            enabled: widget.enabled,
            onChanged: _onChange,
          ),
        ),
      ),
    );
  }

  void _onChange(String value) {
    widget.onChanged?.call(_getCompleteCode());
  }

  String _getCompleteCode() {
    return _codeControllers.map((controller) => controller.text).join();
  }
}

class DigitField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final TextStyle? textStyle;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const DigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
    this.textStyle,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<DigitField> createState() => _DigitFieldState();
}

class _DigitFieldState extends State<DigitField> {
  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: _handleKeyPress,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        enabled: widget.enabled,
        style: widget.textStyle?.copyWith(
          color: widget.enabled ? AppColors.textPrimary : AppColors.textSecondary,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(AppSpacing.$75),
          border: InputBorder.none,
        ),
        showCursor: true,
        enableInteractiveSelection: true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: _handleChange,
        onEditingComplete: () {
          _handleChange(widget.controller.text);
          if (widget.nextFocusNode == null) {
            widget.focusNode.unfocus();
          }
        },
      ),
    );
  }

  void _handleChange(String value) {
    if (value.isNotEmpty && widget.nextFocusNode != null) {
      widget.nextFocusNode!.requestFocus();
    } else {
      if (value.isNotEmpty) {
        widget.controller.text = value[value.length - 1];
      }
    }
    widget.onChanged?.call(value);
  }

  KeyEventResult _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (widget.controller.text.isEmpty && widget.previousFocusNode != null) {
          widget.previousFocusNode!.requestFocus();
          return KeyEventResult.handled;
        }
      }
    }
    return KeyEventResult.ignored;
  }
}
