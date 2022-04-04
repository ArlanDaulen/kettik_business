import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_tour_provider.dart';
import 'package:kettik_business/pages/my_tour/ui/add_contain.dart';
import 'package:kettik_business/pages/my_tour/ui/add_place.dart';
import 'package:kettik_business/pages/my_tour/ui/add_place_2.0.dart';
import 'package:kettik_business/pages/my_tour/ui/edit_images.dart';
import 'package:kettik_business/pages/my_tour/ui/period_picker_tour.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';

class CreateTourScreen extends StatelessWidget {
  const CreateTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<CreateTourProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return SafeArea(
            child: KeyboardDismissOnTap(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    "createTour".tr(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  backgroundColor: AppColors.bgColor,
                  centerTitle: true,
                ),
                // backgroundColor: Color.fromARGB(255, 240, 240, 240),
                body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        model.images != null && model.images!.isEmpty
                            ? InkWell(
                                onTap: () async {
                                  await model.loadImages(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  width: model.size!.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.systemDarkGrayColor
                                                .withOpacity(0.2),
                                            offset: const Offset(0, 2),
                                            blurRadius: 3,
                                            spreadRadius: 3)
                                      ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "addImages".tr(),
                                    style: const TextStyle(
                                        color: AppColors.systemBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                        height: 250,
                                        viewportFraction: 0.95,
                                        autoPlay: true),
                                    items: model.images!.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              decoration: const BoxDecoration(
                                                  color: Colors.deepPurple),
                                              child: Image.file(
                                                File(i.path),
                                                fit: BoxFit.cover,
                                              ));
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(40)),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: getProportionateScreenWidth(30)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // await model.addImages(context);
                                            await model.loadImages(context);
                                          },
                                          child: Container(
                                            width: model.size!.width * 0.2,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: getProportionateScreenWidth(
                                                20)),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        EditImagesScreen(
                                                          createTourProvider:
                                                              model,
                                                        )));
                                          },
                                          child: Container(
                                            width: model.size!.width * 0.2,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: getProportionateScreenWidth(
                                                20)),
                                        InkWell(
                                          onTap: () {
                                            _clearDialog(context, model);
                                          },
                                          child: Container(
                                            width: model.size!.width * 0.2,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: AppColors.systemRedColor
                                                    .withOpacity(0.7)
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Text(
                                              "Clear",
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                ],
                              ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10),
                              horizontal: getProportionateScreenWidth(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              TextFormField(
                                controller: model.titleController,
                                decoration: InputDecoration(
                                    label: Text("title".tr()),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              TextFormField(
                                controller: model.descriptionController,
                                minLines: 5,
                                maxLines: 15,
                                decoration: InputDecoration(
                                    label: Text("description".tr()),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(40)),
                              Text("city".tr()),
                              DropdownButton(
                                value: model.city,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: model.cities.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.setCity(newValue!);
                                },
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(40)),

                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    model.tourDateAndCountPersonsList.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: model.size!.width,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        PeriodPickerOfTour(
                                                          createTourProvider:
                                                              model,
                                                          tourDateAndCountPersons:
                                                              model.tourDateAndCountPersonsList[
                                                                  index],
                                                        )));
                                          },
                                          child: Container(
                                            width: model.size!.width * 0.4,
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.25),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        29),
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        18)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                    Icons.calendar_month),
                                                Text(model.getDateRangeOfTour(
                                                    model.tourDateAndCountPersonsList[
                                                        index]))
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            BottomPicker(
                                                    items: model
                                                        .getCountRangeTextList(),
                                                    title:
                                                        "Choose count of person",
                                                    buttonAlignement:
                                                        MainAxisAlignment.end,
                                                    buttonText: "Select",
                                                    buttonTextStyle:
                                                        const TextStyle(
                                                            color: AppColors
                                                                .whiteColor),
                                                    displayButtonIcon: false,
                                                    bottomPickerTheme:
                                                        BOTTOM_PICKER_THEME
                                                            .plumPlate,
                                                    dismissable: true,
                                                    onSubmit: (value) {
                                                      model.setCountOfPerson(
                                                          value,
                                                          model.tourDateAndCountPersonsList[
                                                              index]);
                                                    },
                                                    titleStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15))
                                                .show(context);
                                          },
                                          child: Container(
                                            width: index == 0
                                                ? model.size!.width * 0.4
                                                : model.size!.width * 0.3,
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.25),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        29),
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        18)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                    Icons.group_add_sharp),
                                                Text(
                                                    "${model.tourDateAndCountPersonsList[index].countPersonsOfTour}"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        index == 0
                                            ? const SizedBox()
                                            : IconButton(
                                                onPressed: () {
                                                  model
                                                      .deleteDateAndCountOfPersons(
                                                          index);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: AppColors
                                                      .systemRedColor
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              model.tourDateAndCountPersonsList.length >= 5
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    20)),
                                        _addMoreDetailInfo(model, () {
                                          model.addMoreDatesForTours();
                                        }, "addMore".tr(), ""),
                                      ],
                                    ),

                              SizedBox(
                                  height: getProportionateScreenHeight(40)),
                              Text(
                                "additionalLocations".tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              model.placesList.isEmpty
                                  ? const Text("- Empty list")
                                  : ListView.builder(
                                      itemCount: model.placesList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Text(" - " +
                                            model.placesList[index].name!);
                                      }),

                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                              _addMoreDetailInfo(model, () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => AddPlaceScreen(
                                //               createTourProvider: model,
                                //             )));
                                Navigator.push(
<<<<<<< HEAD
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AddPlaceScreen(
                                              createTourProvider: model,
                                            )));
                              }, "addPlace".tr(), "description"),
=======
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddPlaceScreen2(createTourProvider: model,),
                                  ),
                                );
                              }, "Add place", "description"),
>>>>>>> eb0187db39bae27a653469a0923eda6bb7d1715c

                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),

                              Text(
                                "tourServices".tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              model.containList.isEmpty
                                  ? const Text("- Empty list")
                                  : ListView.builder(
                                      itemCount: model.containList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Text(
                                            " - " + model.containList[index]);
                                      }),

                              SizedBox(
                                  height: getProportionateScreenHeight(20)),

                              _addMoreDetailInfo(model, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddContainScreen(
                                            createTourProvider: model)));
                              }, "addService".tr(), ""),

                              SizedBox(
                                height: getProportionateScreenHeight(50),
                              ),
                              //price double
                              Text("ticketPrice".tr()),
                              SizedBox(
                                height: getProportionateScreenHeight(5),
                              ),
                              TextFormField(
                                controller: model.priceOfTourController,
                                decoration: InputDecoration(
                                  hintText: "10000",
                                  suffixText: "тенге",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  prefixIcon: const Icon(Icons.monetization_on),
                                ),
                              ),

                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),

                              DefaultButton(
                                press: () {},
                                text: "create".tr(),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
        model: CreateTourProvider());
  }

  _addMoreDetailInfo(
      CreateTourProvider model, func, String title, String description) {
    return SizedBox(
      width: model.size!.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(),
          InkWell(
            onTap: () {
              func();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(15)),
              width: model.size!.width * 0.4,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                title,
                style: const TextStyle(color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_clearDialog(BuildContext context, CreateTourProvider createTourProvider) {
  return showDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(
        'Вы действительно хотите очистить картинки?',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(36),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(
            'Нет',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(32),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(
            'Да',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(32),
            ),
          ),
          onPressed: () {
            createTourProvider.clearImages();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
