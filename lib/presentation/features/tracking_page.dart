import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renda_assessment/presentation/components/shared/custom_btn.dart';
import 'package:renda_assessment/presentation/components/shared/custom_text.dart';
import 'package:renda_assessment/presentation/components/shared/gap.dart';
import 'package:renda_assessment/res/app_assets.dart';
import 'package:renda_assessment/res/constants/app_colors.dart';
import 'package:renda_assessment/utils/extension.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 200), () => trackingDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: 'Tracking “NB145618X8S”',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            Icon(Icons.more_horiz)
          ],
        ),
      ),
      body:  Column(
        children: [
          Container(
            height: fullHeight * .5,
            width: fullWidth,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryLight.withOpacity(.2),
              image: DecorationImage(image: AssetImage(AppAssets.mapImg),fit: BoxFit.cover,)
            ),
          )
        ],
      ),
    );
  }

  void trackingDetails() {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevents dismissing by tapping outside
      isScrollControlled: true,
      enableDrag: false, // Disable default drag behavior
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.kTransparent,
      builder: (BuildContext context) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent < 0.5) {
              // Force bottom sheet back to minChildSize if dragged below
              WidgetsBinding.instance.addPostFrameCallback((_) {
                DraggableScrollableActuator.reset(context);
              });
            }
            return true;
          },
          child: DraggableScrollableActuator(
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              maxChildSize: .85,
              minChildSize: 0.5,
              expand: false,
              builder: (context, controller) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(16),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kBlack.withOpacity(.02),
                        blurRadius: 10,
                        spreadRadius: 10,
                        offset: const Offset(0, -4),
                      )
                    ],
                  ),
                  child: ListView(
                    controller: controller,
                    shrinkWrap: true,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextView(
                            text: 'Your parcel is on the way',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          Gap(20),
                          TextView(
                            text: 'Your parcel is on the way',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const Gap(20),
                      Divider(
                        thickness: 1,
                        color: AppColors.kPrimaryBright.withOpacity(.2),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.ownerImg)),
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                text: 'Martins Jim',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.awardIcon),
                                  const Gap(10),
                                  const TextView(
                                    text: '4,5',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  )
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          tapChip(
                              color: AppColors.kPrimary,
                              icon: AppAssets.messageIcon,
                              size: 15),
                          const Gap(10),
                          tapChip(
                              color: AppColors.kPrimary,
                              icon: AppAssets.phoneIcon,
                              size: 15),
                        ],
                      ),
                      const Gap(7.5),
                      Divider(
                        thickness: 1,
                        color: AppColors.kPrimaryBright.withOpacity(.2),
                      ),
                      const Gap(7.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mainChip(
                              mainText: 'Delivery Type ',
                              subText: 'Express',
                              icon: AppAssets.deliveryIcon),
                          mainChip(
                              mainText: 'Estimate',
                              subText: '1 Day',
                              icon: AppAssets.estimateIcon),
                          mainChip(
                              mainText: 'Weight',
                              subText: '10Kg',
                              icon: AppAssets.weightIcon),
                        ],
                      ),
                      const Gap(15),
                      Divider(
                        thickness: 1,
                        color: AppColors.kPrimaryBright.withOpacity(.2),
                      ),
                      const Gap(15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              trackStep(
                                  color: AppColors.kPrimaryBright,
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.kWhite,
                                    size: 15,
                                  ),
                                  mainText: 'Successfully Delivered',
                                  subText: 'December | 09:10 AM ',
                                  length: 60
                              ),
                              trackStep(
                                  color: AppColors.kBlack,
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.kWhite,
                                    size: 15,
                                  ),
                                  mainText: 'In Transit',
                                  subText: '2km - December | 09:10 AM',
                                  length: 60),
                              trackStep(
                                  color: AppColors.kBlack,
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.kWhite,
                                    size: 15,
                                  ),
                                  haveDetails: true,
                                  mainText: 'Pickup Confirmation',
                                  subText: '2km - December | 09:10 AM ',
                                  picker: 'Skot adams',
                                  length: 100),
                              trackStep(
                                  color: AppColors.kDarkOrange,
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.kWhite,
                                    size: 15,
                                  ),
                                  mainText: 'Parcel Preparation',
                                  subText: '2km - December | 09:10 AM ',
                                  length: 60),
                              trackStep(
                                  color: AppColors.kDarkOrange.withOpacity(.5),
                                  trackLines: false,
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.kWhite,
                                    size: 15,
                                  ),
                                  mainText: 'Parcel Received',
                                  subText: '2km - December | 09:10 AM ',
                                  length: 60),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget trackStep({color, icon, required double length, mainText, subText, bool trackLines = true,bool haveDetails = false, picker}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  border: Border.all(color: color, width: 4),
                  shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: color,
                child: icon,
              ),
            ),
            Visibility(
              visible: trackLines,
              child:DottedLine(
              dashLength: 10,
              dashGapLength: 5,
              lineThickness: 2,
              dashColor: color,
              direction: Axis.vertical,
              lineLength: length,
            ),
            )
          ],
        ),
        const Gap(10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: mainText,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            const Gap(10),
            TextView(
              text: subText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.kGrey,
            ),
            const Gap(10),
            haveDetails ? Container(
              width: fullWidth * .75,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withOpacity(.2),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kGrey),
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(AppAssets.userImg,),fit: BoxFit.cover)
                    ),
                  ),
                  const Gap(10),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(text: 'Service delivery', fontSize: 10,fontWeight: FontWeight.w600,color: AppColors.kDarkGreen,),
                      TextView(text: '${picker}, picked your parcel',fontSize: 9,fontWeight: FontWeight.w700,color: AppColors.kDarkGreen,),
                    ],
                  ),
                  const Spacer(),
                  outlinedTapChip(
                      icon: AppAssets.messageIcon,),
                  const Gap(10),
                  outlinedTapChip(
                      icon: AppAssets.phoneIcon,),
                ],
              ),
            ) : const SizedBox.shrink()
          ],
        )
      ],
    );
  }
  Widget tapChip({color, icon, required double size}) {
    return CircleAvatar(
      radius: size,
      backgroundColor: color.withOpacity(.2),
      child: SvgPicture.asset(
        icon,
        color: AppColors.kDarkGreen,
      ),
    );
  }
  Widget outlinedTapChip({icon}){
    return Container(
      
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.kTransparent,
        shape:BoxShape.circle,
        border: Border.all(color: AppColors.kBlack,width: 1)
      ),
      child: SvgPicture.asset(
        icon,
        color: AppColors.kDarkGreen,
        fit: BoxFit.cover,
      ),
    );
  }
  Widget mainChip(
      {required String icon,
      required String mainText,
      required String subText}) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.kPrimaryBright.withOpacity(.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(icon),
          ),
        ),
        const Gap(10),
        TextView(
          text: mainText,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        const Gap(10),
        TextView(
          text: subText,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.kGrey,
        ),
      ],
    );
  }
}
