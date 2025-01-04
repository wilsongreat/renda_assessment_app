import 'package:flutter/material.dart';
import 'package:renda_assessment/presentation/components/shared/custom_btn.dart';
import 'package:renda_assessment/presentation/components/shared/custom_text.dart';
import 'package:renda_assessment/presentation/components/shared/gap.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/utils/extension.dart';

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({this.onRetryPress, super.key});
  final void Function()? onRetryPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight,
      width: fullHeight,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const SizedBox.square(
            dimension: 70,
            child: Icon(
              Icons.refresh_rounded,
              size: 80,
              color: AppColors.kPrimary,
            ),
          ),
          const Gap(20),
          const TextView(
           text:  'An Error occured, please check network connection and try again',
            textAlign: TextAlign.center,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const Gap(10),
          CustomAppButton(
            width: 150,
            title: 'try again',
            voidCallback: onRetryPress,
          ),
        ],
      ),
    );
  }
}
