import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/my_tour_provider.dart';
import 'package:kettik_business/pages/my_tour/ui/add_place.dart';
import 'package:kettik_business/pages/my_tour/ui/create_tour.dart';
import 'package:kettik_business/pages/my_tour/ui/tour_detail.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/loading_view.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class MyTourScreen extends StatelessWidget {
  const MyTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<MyTourProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : KeyboardDismissOnTap(
                  child: Scaffold(
                    backgroundColor: AppColors.bgColor,
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(120),
                              bottom: getProportionateScreenHeight(20),
                              right: getProportionateScreenWidth(30),
                              left: getProportionateScreenWidth(30),
                            ),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1, 1),
                                  color: AppColors.systemBlackColor
                                      .withOpacity(0.15),
                                  blurRadius: 3,
                                  spreadRadius: 3)
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Туры",
                                  style: TextStyle(
                                      color: AppColors.systemBlackColor
                                          .withOpacity(0.95),
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(30),
                                ),
                                TextFormField(
                                  style: const TextStyle(
                                      color: AppColors.systemBlackColor),
                                  controller: model.searchController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: AppColors.systemBlackColor
                                          .withOpacity(0.9),
                                      hintText: "searchTours".tr(),
                                      hintStyle: TextStyle(
                                          color: AppColors.systemBlackColor
                                              .withOpacity(0.9)),
                                      prefixIcon: Icon(Icons.search,
                                          color: AppColors.systemBlackColor
                                              .withOpacity(0.9)),
                                      suffixIcon: model.isSearching
                                          ? TextButton(
                                              onPressed: () {
                                                model.cancelSearching(context);
                                              },
                                              child: const Text(
                                                "Отменить",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            )
                                          : const SizedBox()),
                                  onChanged: (value) async {
                                    await model.searchTourByName(
                                        context, value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: model.size!.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(40),
                                vertical: getProportionateScreenHeight(30)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: getProportionateScreenHeight(30),
                                ),
                                ListView.separated(
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: model.tourList.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    TourDetailScreen(id: 1)));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0, 3),
                                                  color: AppColors
                                                      .systemDarkGrayColor,
                                                  blurRadius: 5,
                                                  spreadRadius: 0.1)
                                            ]),
                                        width: model.size!.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                //imagecontainer
                                                SizedBox(
                                                  width: model.size!.width,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      "https://www.remotelands.com/storage/media/396/responsive-images/b140811017___banner-size_1920_940.jpg",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                // info {rating, dates,city}
                                                Container(
                                                  width: model.size!.width,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          getProportionateScreenHeight(
                                                              20),
                                                      horizontal:
                                                          getProportionateScreenWidth(
                                                              20)),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        model.tourList[index]
                                                                .name ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    36),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        model.tourList[index]
                                                                .city ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    25),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                7),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical:
                                                                getProportionateScreenHeight(
                                                                    10),
                                                            horizontal:
                                                                getProportionateScreenWidth(
                                                                    15)),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Text(
                                                          model.tourList[index]
                                                              .rating
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      30),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .whiteColor),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                15),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              AppSvgImages
                                                                  .departure_date_ic),
                                                          SizedBox(
                                                              width:
                                                                  getProportionateScreenWidth(
                                                                      20)),
                                                          Text(model
                                                                  .tourList[
                                                                      index]
                                                                  .timeRange ??
                                                              ""),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                15),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.group),
                                                          SizedBox(
                                                              width:
                                                                  getProportionateScreenWidth(
                                                                      20)),
                                                          Text(model
                                                              .tourList[index]
                                                              .countOfPlaces!
                                                              .toString()),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                10),
                                                      ),
                                                      model.getShortText(
                                                          model.tourList[index]
                                                              .description!,
                                                          index),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                20),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: getProportionateScreenHeight(40),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(200),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPlaceScreen()));
                      },
                      child: SvgPicture.asset(
                        AppSvgImages.add_tour_ic,
                        color: AppColors.whiteColor,
                      ),
                      backgroundColor: Color.fromARGB(255, 107, 0, 194),
                    ),
                  ),
                );
        },
        model: MyTourProvider());
  }
}
