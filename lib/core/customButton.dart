

import 'package:flutter/material.dart';
import 'package:onix_bot/core/responsive_ext.dart';
import 'package:onix_bot/core/style/app_colors.dart';
import 'package:onix_bot/core/style/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Icon? icon;
  final Color? bgcColor;
  final Color? textColor;
  final double? circularRadius;
  final double? height;
  final double? width;
  final bool isLoading;
  final bool isEnabled;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    this.onPressed,
    this.title,
    this.icon,
    this.height,
    this.width,
    this.textColor,
    this.circularRadius,
    this.bgcColor,
    this.isLoading = false,
    this.isEnabled = true,
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        height: height ?? context.height / 18,
        width: width ?? context.width / 1.2,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadius ?? 18),
          ),
          color: !isEnabled ? Colors.white : bgcColor ?? kPrimaryColor,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    if (icon != null && title != null)
                      SizedBox(width: 10,), // Add spacing between icon and text
                    if (title != null)
                      Text(
                        title!,
                        style: AppTextStyles.styleLight14(context,
                            color: textColor ?? whiteColor),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
