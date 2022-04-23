import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/pages/profile/ui/add_address.dart';
import 'package:kettik_business/pages/profile/ui/add_contacts.dart';
import 'package:kettik_business/pages/profile/ui/add_description.dart';
import 'package:kettik_business/pages/profile/ui/choose_city.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';

class AboutBusinessScreen extends StatefulWidget {
  AboutBusinessScreen({Key? key, required this.model}) : super(key: key);
  final ProfileProvider model;

  @override
  State<AboutBusinessScreen> createState() => _AboutBusinessScreenState();
}

class _AboutBusinessScreenState extends State<AboutBusinessScreen> {
  String? currentCity;
  String? currentDescription;
  List<TextEditingController>? contactControllers;
  List<TextEditingController>? addressControllers;

  void _onCityChosen(String city) {
    setState(() {
      currentCity = city;
    });
    widget.model.setCurrentCity(city);
  }

  void _onDescriptionAdded(String text) {
    setState(() {
      currentDescription = text;
    });
    // TODO: set description method
  }

  void _onContactsAdded(List<TextEditingController> controllers) {
    setState(() {
      contactControllers = controllers;
    });
  }

  void _onAddressAdded(List<TextEditingController> controllers) {
    setState(() {
      addressControllers = controllers;
    });
  }

  @override
  void initState() {
    super.initState();
    currentCity = widget.model.currentCity;
    // TODO: initialize current description
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'aboutBusiness'.tr(),
        isWithBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(40),
          vertical: getProportionateScreenHeight(40),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            _buildSections(
              title: 'city'.tr(),
              text: currentCity == null ? 'chooseCity'.tr() : currentCity!,
              page: ChooseCityScreen(
                profileProvider: widget.model,
                onCityChosen: _onCityChosen,
              ),
              isEnabled: false,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _buildSections(
              title: 'description'.tr(),
              text: currentDescription == null
                  ? 'addDescription'.tr()
                  : currentDescription!,
              page: AddDescriptionScreen(
                onDescriptionAdded: _onDescriptionAdded,
              ),
              isEnabled: currentDescription != null,
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _buildContacts(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _buildAddress(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }

  _buildSections({
    required String title,
    required String text,
    required Widget page,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        color: AppColors.systemGreenColor.withOpacity(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(32),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(28),
                fontWeight: FontWeight.w500,
                color: isEnabled
                    ? AppColors.systemBlackColor
                    : AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            const Divider(
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  _buildContacts() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AddContactsScreen(
                    onContactAdded: _onContactsAdded,
                  ))),
      child: Container(
        color: AppColors.systemGreenColor.withOpacity(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'contacts'.tr(),
              style: TextStyle(
                fontSize: getProportionateScreenHeight(32),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            contactControllers == null
                ? Text(
                    'addContacts'.tr(),
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(28),
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (contactControllers![1].text != '' &&
                          contactControllers![2].text != '')
                        _buildContactsData(1, 2, AppSvgImages.person_ic),
                      if (contactControllers![0].text != '')
                        _buildContactsData(0, null, AppSvgImages.email_ic),
                      if (contactControllers![3].text != '')
                        _buildContactsData(
                            3, null, AppSvgImages.telegram_dark_ic),
                      if (contactControllers![4].text != '')
                        _buildContactsData(
                            4, null, AppSvgImages.whatsapp_dark_ic),
                    ],
                  ),
            const Divider(
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  _buildContactsData(int index, int? index2, String icon) => Row(
        children: [
          SvgPicture.asset(
            icon,
            width: getProportionateScreenWidth(25),
            height: getProportionateScreenHeight(30),
          ),
          SizedBox(
            width: getProportionateScreenWidth(20),
          ),
          Text(
            index2 == null
                ? contactControllers![index].text
                : contactControllers![index].text +
                    ' ' +
                    contactControllers![index2].text,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(28),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );

  _buildAddress() => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    AddAddressScreen(onAddressAdded: _onAddressAdded))),
        child: Container(
          color: AppColors.systemGreenColor.withOpacity(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'companyContacts'.tr(),
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(32),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              addressControllers == null
                  ? Text(
                      'addAddress'.tr(),
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(28),
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (addressControllers![0].text != '')
                          _buildAddressData(0, AppSvgImages.location_ic),
                        if (addressControllers![1].text != '')
                          _buildAddressData(1, AppSvgImages.phone_home_ic),
                        if (addressControllers![2].text != '')
                          _buildAddressData(2, AppSvgImages.web_ic),
                      ],
                    ),
              const Divider(
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      );

  _buildAddressData(int index, String icon) => Row(
        children: [
          SvgPicture.asset(
            icon,
            width: getProportionateScreenWidth(25),
            height: getProportionateScreenHeight(30),
          ),
          SizedBox(
            width: getProportionateScreenWidth(20),
          ),
          Text(
            addressControllers![index].text,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(28),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
}
