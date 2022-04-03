import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/pages/home/ui/contact_with_client_screen.dart';
import 'package:kettik_business/pages/home/ui/widgets/chart_bar.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';

class TourDetailsScreen extends StatelessWidget {
  TourDetailsScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: name,
        isWithBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Image.asset(
                AppPngPaths.charyn_ic,
                width: double.maxFinite,
                height: getProportionateScreenHeight(354),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(48),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '8.5',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: getProportionateScreenHeight(24),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                ),
                child: Text(
                  'Almaty, Kazakhstan',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(24),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(20),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
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
                child: ChartBar(),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: Text(
                  'List of clients',
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(36),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (_, index) => SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(20),
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
                    ],
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactWithClientScreen(),
                      ),
                    ),
                    leading: SvgPicture.asset(
                      AppSvgImages.avatar_ic,
                      width: getProportionateScreenWidth(87),
                      height: getProportionateScreenHeight(94),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amangeldi Sparta',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '+7 (667) 667-6969',
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(18),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                            SvgPicture.asset(
                              AppSvgImages.telegram_ic,
                              width: getProportionateScreenWidth(24),
                              height: getProportionateScreenHeight(24),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                            Image.asset(
                              AppPngPaths.whatsapp_ic,
                              width: getProportionateScreenWidth(30),
                              height: getProportionateScreenHeight(30),
                            ),
                          ],
                        ),
                        Text(
                          'spartakorolevagoril@gmail.com',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.systemBlackColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
