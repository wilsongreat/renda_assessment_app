import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renda_assessment/presentation/features/tracking_delivery/tracking_page.dart';
import 'package:renda_assessment/providers/deliveries_view_model.dart';
import 'package:renda_assessment/res/app_assets.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/src/components.dart';
import 'package:renda_assessment/utils/extension.dart';

class ShowBottomSheet extends ConsumerStatefulWidget {
  const ShowBottomSheet({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends ConsumerState<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(deliveriesViewModelProvider.notifier);
    final item = provider.deliveryList.firstWhere((e) => e.id == widget.id);
    return SizedBox(
        height: 300,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .3,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextView(
                text: 'Results for ${item.trackingId}',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kBlack
                          .withOpacity(0.2), // Shadow color with transparency
                      blurRadius: 5, // Soften the shadow
                      // spreadRadius: 2, // Extend the shadow
                      offset: const Offset(0, 4), // Shift shadow upwards
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        AppAssets.parcelImg,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                            text: item.trackingId.toString(),
                            fontWeight: FontWeight.bold,
                            color: AppColors.kDarkGreen),
                        const Text('On the way in transit'),
                        const Gap(5),
                        SizedBox(
                          height: 10,
                          width: fullWidth * .5,
                          child: LinearProgressIndicator(
                            backgroundColor: AppColors.kGrey.withOpacity(.3),
                            color: AppColors.kBlack,
                            value: 0.3,
                            borderRadius: BorderRadius.circular(10),
                            // valueColor: An,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryLight,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextView(
                          text: item.status ?? '',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kPrimary),
                    )
                  ],
                ),
              ),
              const Gap(40),
              CustomAppButton(
                title: 'Details Live',
                voidCallback: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => TrackingPage(
                        id: widget.id,
                      ),
                    ),
                  );
                },
                btnIcon: SvgPicture.asset(
                  AppAssets.trailIcon,
                  color: AppColors.kBlack,
                ),
              )
            ],
          ),
        ));
  }
}
