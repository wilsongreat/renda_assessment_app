import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renda_assessment/presentation/features/tracking_delivery/tracking_page.dart';
import 'package:renda_assessment/providers/deliveries_view_model.dart';
import 'package:renda_assessment/res/app_assets.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/src/components.dart';
import 'package:renda_assessment/utils/extension.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../utils/debouncer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(deliveriesViewModelProvider.notifier).fetchDeliveries();
    });
  }

  void onChanged(String val) {
    final provider = ref.read(deliveriesViewModelProvider.notifier);
    final debouncer = Debouncer(duration: 100);

    debouncer.run(() async {
      provider.searchDeliveries(val);
      setState(() {});
    });
  }

  void showSheet(String id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ShowBottomSheet(
            id: id,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(deliveriesViewModelProvider.notifier);
    final stateProvider = ref.watch(deliveriesViewModelProvider);
    return Scaffold(
      // backgroundColor: AppColors.kWhite.withOpacity(.9),
      body:  (stateProvider.hasError)
          ? ErrorPlaceholder(
        onRetryPress: provider.fetchDeliveries,
      )
          :  Skeletonizer(
        enabled: stateProvider.isLoading,
        child: Column(
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
                    onChanged: onChanged,
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

                  // const ShowBottomSheet()
                ],
              ),
            ),
            Expanded(
              child:provider.searchList.isNotEmpty? ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    final val = provider.searchList[index];
                    // final status =
                    //     locator.get<SharedPrefs>().getList(val.id ?? '');
                    // print(status);
                    if (provider.searchList.isNotEmpty) {
                    return  GestureDetector(
                      onTap: () =>showSheet(val.id ?? ''),
                      child: Container(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(15),
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
                                      text: val.trackingId.toString(),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.kDarkGreen),
                                  const Gap(5),
                                   TextView(
                                      text: val.senderName.toString(),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.kDarkGreen),
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
                                    text: val.status ?? '',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kPrimary),
                              )
                            ],
                          ),
                        ),
                    );
                      // return GestureDetector(
                      //   onTap: () {
                      //     showSheet(val.id ?? '');
                      //   },
                      //   child: Text(
                      //     val.senderName ?? '',
                      //     style: const TextStyle(
                      //       fontSize: 20,
                      //       color: AppColors.kDarkGreen,
                      //     ),
                      //   ),
                      // );
                    }else{
                      return const TextView(text: "NO delivery available");
                    }
                  },
                  separatorBuilder: (_, index) => const Gap(10),
                  itemCount: provider.searchList.length): Center(child: TextView(text: 'No delivery item was found',fontSize: 16,fontWeight: FontWeight.w600,),),
            ),
          ],
        ).animate().fadeIn(duration: Duration(milliseconds: 800)),
      ),
    );
  }
}

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
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
