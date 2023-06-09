// 🐦 Flutter imports:
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 🌎 Project imports:

class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final String label;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final bool? readOnly;
  final void Function()? onTap;

  const AppTextField(
      {Key? key,
      this.labelText,
      this.initialValue,
      this.suffixIcon,
      this.inputType,
      this.textCapitalization = TextCapitalization.none,
      this.onChanged,
      this.onEditingComplete,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.label = '',
      this.maxLines = 1,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.enableInteractiveSelection = true,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.enabled = true,
      this.onFieldSubmitted,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          onSaved: onSaved,
          onEditingComplete: onEditingComplete,
          cursorColor: AppColors.grey100.withOpacity(0.5),
          obscureText: obscureText!,
          enableInteractiveSelection: enableInteractiveSelection,
          maxLines: maxLines,
          readOnly: readOnly!,
          focusNode: focusNode,
          enableIMEPersonalizedLearning: true,
          enableSuggestions: true,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
          obscuringCharacter: '*',
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
          keyboardType: inputType,
          textAlign: textAlign,
          textInputAction: textInputAction,
          enabled: enabled,
          style: Config.b1(context).copyWith(
            color: AppColors.primaryColor,
          ),
          decoration: InputDecoration(
              fillColor: AppColors.textfieldColor,
              focusColor: AppColors.white100,
              filled: true,
              label: Text(
                hintText!,
                style: Config.b3(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.grey100.withOpacity(0.5),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.grey100.withOpacity(0.5),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.errorColor,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.white100,
                  width: 1,
                ),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: labelText,
              hintText: label == '' ? 'Enter $hintText' : '$hintText',
              hintStyle: Config.b2(context).copyWith(
                color: AppColors.grey100.withOpacity(0.5),
              )),
          onChanged: onChanged,
          validator: validator,
          onTap: onTap,
        ),
      ],
    );
  }
}
