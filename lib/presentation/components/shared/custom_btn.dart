import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renda_assessment/presentation/components/shared/gap.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/utils/extension.dart';



class CustomAppButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? innActiveColor;
  final VoidCallback? voidCallback;
  final bool? isActive;
  final bool? withEmoji;
  final Widget? btnIcon;
  final double? radius;
  final double? width;
  final double? height;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const CustomAppButton({
    super.key,
    this.title,
    this.color,
    this.innActiveColor,
    this.isActive,
    this.withEmoji,
    this.btnIcon,
    this.voidCallback,
    this.radius,
    this.textColor,
    this.width,
    this.fontWeight,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap:  voidCallback,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        height: height ?? fullHeight * .06,
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
          color:  color ?? AppColors.kPrimaryBright,

          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  title?.toUpperCase() ?? '  ',
                  style: GoogleFonts.nunito(
                      color: textColor ?? AppColors.kBlack,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      fontSize: fontSize ?? 16),
                )),
            const Gap(10),
            btnIcon ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}