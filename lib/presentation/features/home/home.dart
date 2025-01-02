import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renda_assessment/presentation/components/shared/custom_btn.dart';
import 'package:renda_assessment/presentation/components/shared/custom_input.dart';
import 'package:renda_assessment/presentation/components/shared/custom_text.dart';
import 'package:renda_assessment/presentation/components/shared/gap.dart';
import 'package:renda_assessment/presentation/features/tracking_page.dart';
import 'package:renda_assessment/providers/deliveries_view_model.dart';
import 'package:renda_assessment/res/app_assets.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/utils/extension.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(deliveriesViewModelProvider.notifier).fetchDeliveries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(deliveriesViewModelProvider.notifier);
    return Scaffold(
      // backgroundColor: AppColors.kWhite.withOpacity(.9),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            decoration: const BoxDecoration(
                color: AppColors.kWhite,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.kGrey),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                AppAssets.userImg,
                              ),
                              fit: BoxFit.cover)),
                    ),
                    const Gap(15),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: 'Good morning 👋',
                          color: AppColors.kDarkGreen,
                        ),
                        TextView(
                          text: 'Jane Doe',
                          color: AppColors.kDarkGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        provider.fetchDeliveries();
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.kDarkGreen.withOpacity(.2),
                        child: const Icon(
                          Icons.notifications_rounded,
                          color: AppColors.kDarkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                CustomTextField(
                  prefixIconSize: const Size(30, 30),
                  prefixIcon: AppAssets.searchIcon,
                  prefixIconColor: AppColors.kGrey.withOpacity(.5),
                  hintColor: AppColors.kGrey.withOpacity(.5),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    child: CircleAvatar(
                      backgroundColor: AppColors.kPrimaryBright,
                      child: SvgPicture.asset(
                        AppAssets.scanIcon,
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                  hint: 'Enter track ID number',
                  hintTextSize: 16,
                  fillColor: AppColors.kWhite.withOpacity(0.10),
                ),
                const Gap(5),
                GestureDetector(
                    onTap: provider.fetchDeliveries,
                    child: const TextView(
                      text: 'Enter parcel number or scan QR code',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.kDarkGreen,
                    )),
                const ShowBottomSheet()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return TextView(
      text: 'SHOW SHEETS',
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
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
                        const TextView(
                          text: 'Results for “NB145618X8S”',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(
                                    0.2), // Shadow color with transparency
                                blurRadius: 5, // Soften the shadow
                                // spreadRadius: 2, // Extend the shadow
                                offset:
                                    const Offset(0, 4), // Shift shadow upwards
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
                                  const TextView(
                                      text: 'NB145618X8S',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.kDarkGreen),
                                  const Text('On the way in transit'),
                                  const Gap(5),
                                  SizedBox(
                                    height: 10,
                                    width: fullWidth * .5,
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                          AppColors.kGrey.withOpacity(.3),
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
                                child: const TextView(
                                    text: 'In Transit',
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
                                builder: (BuildContext context) =>
                                    const TrackingPage(),
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
            });
      },
    );
  }
}
