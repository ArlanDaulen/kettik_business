import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/home/provider/home_provider.dart';
import 'package:kettik_business/pages/home/ui/tour_details_screen.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<HomeProvider>(
      model: HomeProvider(),
      onReady: (p0) => p0.init(context),
      builder: (context, model, child) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: AppColors.systemBlackColor.withOpacity(0.05),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(150),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30),
                    vertical: getProportionateScreenHeight(40),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 1,
                          color: AppColors.systemBlackColor.withOpacity(0.25),
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvgImages.calendar_ic,
                            width: getProportionateScreenWidth(45),
                            height: getProportionateScreenHeight(45),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                          ),
                          Text(
                            'Mar 17 - 17 Apr',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(36),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      const Divider(
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      _buildStatSections(
                          AppSvgImages.all_tours_ic, 'totalTours'.tr(), 4),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      _buildStatSections(
                          AppSvgImages.ticket_ic, 'numberOfTickets'.tr(), 44),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      _buildStatSections(
                          AppSvgImages.ticket_ic, 'ticketsSold'.tr(), 23),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      _buildStatSections(
                          AppSvgImages.ticket_ic, 'ticketsLeft'.tr(), 21),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Text(
                  'tourStatistics'.tr(),
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(36),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                ListView.separated(
                  padding: const EdgeInsets.only(top: 0, bottom: 40),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (_, index) => SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                TourDetailsScreen(name: 'Altyn-emel'))),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenHeight(20),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 1,
                              color:
                                  AppColors.systemBlackColor.withOpacity(0.25),
                            )
                          ]),
                      child: Row(
                        children: [
                          Image.asset(
                            AppPngPaths.altym_emel_ic,
                            width: getProportionateScreenWidth(300),
                            height: getProportionateScreenHeight(200),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(20),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Atlyn-emel',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(36),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Almaty, Kazakhstan',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(20),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => SvgPicture.asset(
                                      AppSvgImages.star_ic,
                                      width: getProportionateScreenWidth(20),
                                      height: getProportionateScreenHeight(20),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppSvgImages.departure_date_ic,
                                      width: getProportionateScreenWidth(31),
                                      height: getProportionateScreenHeight(24),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(20),
                                    ),
                                    Text(
                                      '12.04 - 17.04, 5 ' + 'night'.tr(),
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(18),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      AppSvgImages.ticket_dark_ic,
                                      width: getProportionateScreenWidth(31),
                                      height: getProportionateScreenHeight(28),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(20),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'seatsPurchased'.tr() + ': 32',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(18),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppSvgImages.group_ic,
                                      width: getProportionateScreenWidth(31),
                                      height: getProportionateScreenHeight(24),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(20),
                                    ),
                                    Text(
                                      'available'.tr() + ': 8',
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(18),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildStatSections(String icon, String text, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          icon,
          width: getProportionateScreenWidth(45),
          height: getProportionateScreenHeight(45),
        ),
        SizedBox(
          width: getProportionateScreenWidth(40),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(36),
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(
          flex: 2,
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: getProportionateScreenHeight(36),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
