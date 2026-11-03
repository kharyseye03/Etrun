import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

/// Champ de saisie avec libellé au-dessus.
class EtTextField extends StatefulWidget {
  const EtTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscure = false,
    this.prefixIcon,
    this.textInputAction,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscure;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  State<EtTextField> createState() => _EtTextFieldState();
}

class _EtTextFieldState extends State<EtTextField> {
  late bool _hidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.caption),
        const SizedBox(height: AppDimens.sm),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _hidden,
          textInputAction: widget.textInputAction,
          style: AppTextStyles.body,
          cursorColor: AppColors.primaryText,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, color: AppColors.textHint, size: 20),
            suffixIcon: widget.obscure
                ? IconButton(
                    onPressed: () => setState(() => _hidden = !_hidden),
                    icon: Icon(
                      _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppColors.textHint,
                      size: 20,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
