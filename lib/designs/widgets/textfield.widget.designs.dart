import 'package:flutter/material.dart';

import '../colors.designs.dart';
import '../fonts.designs.dart';
import 'icon.widget.designs.dart';

class DesignTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int? minLines;
  final double fontSize;
  final TextInputType inputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? labelText;
  final String? errorText;
  final int? charCount;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double borderRadius;
  final bool hasBorder;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final bool enabled;
  final Color fillColor;
  final Color fontColor;

  const DesignTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.textInputAction,
    this.maxLines = 1,
    this.borderRadius = 8,
    this.fontSize = 16,
    this.hasBorder = true,
    this.focusNode,
    this.labelText,
    this.errorText,
    this.charCount,
    this.minLines,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.enabled = true,
    this.fillColor = Colors.white,
    this.fontColor = DesignColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      keyboardType: inputType,
      textInputAction: textInputAction,
      maxLength: charCount,
      minLines: minLines ?? maxLines,
      maxLines: maxLines,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        filled: true, // Enables background color
        fillColor: fillColor,
        labelText: labelText,
        labelStyle: DesignFonts.poppins.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
        counterStyle: DesignFonts.poppins.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
          borderSide: hasBorder
              ? const BorderSide(color: DesignColors.secondary, width: 1)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? const BorderSide(color: DesignColors.secondary, width: 1)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? const BorderSide(color: DesignColors.secondary, width: 1)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? const BorderSide(color: DesignColors.accent, width: 1)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorStyle: DesignFonts.poppins.copyWith(
          color: DesignColors.accent,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon:
            suffixIcon ??
            (errorText != null
                ? DesignIcon.icon(
                    icon: Icons.error,
                    color: DesignColors.accent,
                    size: 16,
                  )
                : null),
        errorText: errorText,
        hintText: hintText,
        hintStyle: DesignFonts.poppins.copyWith(
          color: DesignColors.secondary,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: DesignFonts.poppins.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: fontColor,
      ),
    );
  }
}
