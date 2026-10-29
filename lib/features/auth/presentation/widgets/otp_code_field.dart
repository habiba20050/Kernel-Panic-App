import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Segmented one-time-password input.
///
/// Boxes are laid out in reading order, so in Arabic the first digit lands on the
/// right. Typing advances the focus, backspace on an empty box steps back, and
/// pasting a full code fills every box at once.
class OtpCodeField extends StatefulWidget {
  const OtpCodeField({
    super.key,
    this.length = 6,
    required this.onChanged,
    required this.onCompleted,
  });

  final int length;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  int _active = 0;

  @override
  void initState() {
    super.initState();
    _controllers = List<TextEditingController>.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _focusNodes = List<FocusNode>.generate(widget.length, (int index) {
      final FocusNode node = FocusNode();
      node.onKeyEvent = (FocusNode focusNode, KeyEvent event) =>
          _handleKey(index, event);
      node.addListener(() {
        if (node.hasFocus && _active != index) {
          setState(() => _active = index);
        }
      });
      return node;
    });
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }
    for (final FocusNode node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _code =>
      _controllers.map((TextEditingController c) => c.text).join();

  bool get _isComplete =>
      _controllers.every((TextEditingController c) => c.text.isNotEmpty);

  void _emit() {
    final String code = _code;
    widget.onChanged(code);
    if (_isComplete) widget.onCompleted(code);
  }

  KeyEventResult _handleKey(int index, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      _emit();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _handleChanged(int index, String value) {
    if (value.length > 1) {
      // Pasting the whole code into one box.
      final String digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].text = i < digits.length ? digits[i] : '';
      }
      _focusNodes[widget.length - 1].requestFocus();
      _emit();
      return;
    }

    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(child: _box(i)),
        ],
      ],
    );
  }

  Widget _box(int index) {
    final bool isActive = _active == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _focusNodes[index].requestFocus(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 54,
        decoration: BoxDecoration(
          color: isActive ? AppColors.surface : AppColors.authFieldFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: AppColors.authFieldGlow,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          textInputAction: index == widget.length - 1
              ? TextInputAction.done
              : TextInputAction.next,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(widget.length),
          ],
          onChanged: (String value) => _handleChanged(index, value),
          cursorColor: AppColors.primary,
          showCursor: false,
          style: AppTextStyles.fieldValue.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          decoration: const InputDecoration(
            counterText: '',
            filled: false,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            // The shared theme paints a filled outline field; the segmented
            // box already owns its own border, so strip every decoration.
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
