import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Text input used across the auth screens.
///
/// The field is filled while idle and switches to a white fill with a primary
/// border plus a soft glow while focused, which is the state shown in the
/// design for the first field of each form.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.obscureText = false,
    this.leadingIcon,
    this.trailing,
    this.autofocus = false,
    this.enabled = true,
  });

  final String hint;
  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  /// Icon rendered on the leading (right, in Arabic) side of the field.
  final IconData? leadingIcon;

  final Widget? trailing;
  final bool autofocus;
  final bool enabled;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus == _hasFocus) return;
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: color == Colors.transparent
          ? BorderSide.none
          : BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = _hasFocus ? AppColors.primary : AppColors.inkMuted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            textAlign: TextAlign.start,
            style: AppTextStyles.fieldLabel,
          ),
          const SizedBox(height: 10),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: _hasFocus
                ? const [
                    BoxShadow(
                      color: AppColors.authFieldGlow,
                      blurRadius: 1.5,
                      spreadRadius: 3,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            textAlign: TextAlign.start,
            style: AppTextStyles.fieldValue,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.fieldHint,
              filled: true,
              fillColor: _hasFocus
                  ? AppColors.surface
                  : AppColors.authFieldFill,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              prefixIcon: widget.leadingIcon == null
                  ? null
                  : Icon(widget.leadingIcon, size: 22, color: iconColor),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 46,
                minHeight: 46,
              ),
              suffixIcon: widget.trailing,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 46,
                minHeight: 46,
              ),
              border: _border(Colors.transparent, 0),
              enabledBorder: _border(
                _hasFocus ? AppColors.primary : Colors.transparent,
                1.5,
              ),
              focusedBorder: _border(AppColors.primary, 1.5),
              errorBorder: _border(AppColors.primaryDark, 1.2),
              focusedErrorBorder: _border(AppColors.primaryDark, 1.5),
              errorStyle: AppTextStyles.fieldHint.copyWith(
                color: AppColors.primaryDark,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
