import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:renda_assessment/providers/deliveries_view_model.dart';
import 'package:renda_assessment/res/app_assets.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/src/components.dart';
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



  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(deliveriesViewModelProvider.notifier);
    final stateProvider = ref.watch(deliveriesViewModelProvider);
    return Scaffold(
      body:  (stateProvider.hasError)
      /// Network error widget handler
          ? ErrorPlaceholder(
        onRetryPress: provider.fetchDeliveries,
      )
          :  SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: provider.refreshController,
        onRefresh: provider.onRefresh,
            child: Skeletonizer(
                    enabled: stateProvider.isLoading,
                    child: Column(
            children: [
              _buildHeader(),
              _deliveryList()
            ],
                    ).animate().fadeIn(duration: const Duration(milliseconds: 800)),
                  ),
          ),
    );
  }
  /// header widget Including the search input field
 Widget _buildHeader(){
   final provider = ref.watch(deliveriesViewModelProvider.notifier);
   return Container(
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
              CircleAvatar(
                backgroundColor: AppColors.kDarkGreen.withOpacity(.2),
                child: const Icon(
                  Icons.notifications_rounded,
                  color: AppColors.kDarkGreen,
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
    );
  }

  /// delivery list widget
  Widget _deliveryList(){
    final provider = ref.watch(deliveriesViewModelProvider.notifier);
    return  Expanded(
      child:provider.searchList.isNotEmpty? ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) {
            final val = provider.searchList[index];
            if (provider.searchList.isNotEmpty) {
              return  GestureDetector(
                onTap: () =>provider.showSheet(val.id ?? '',context),
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
            }else{
              return const TextView(text: "NO delivery available");
            }
          },
          separatorBuilder: (_, index) => const Gap(10),
          itemCount: provider.searchList.length): const Center(child: TextView(text: 'No delivery item was found',fontSize: 16,fontWeight: FontWeight.w600,),),
    ) ;
  }
}



