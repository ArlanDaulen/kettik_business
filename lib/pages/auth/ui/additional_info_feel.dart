import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/auth/provider/additional_info_feel_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/shared/ui_helper.dart';
import 'package:kettik_business/widgets/custom_container.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class AdditionalInfoFeelScreen extends StatelessWidget {
  const AdditionalInfoFeelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<AdditionalInfoFeelProvider>(
        onReady: (_) => _.init(context),
        builder: ((context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UIHelper.verticalSpace(
                        getProportionateScreenHeight(500),
                      ),
                      Text(
                        'Доролнительные сведения.',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: getProportionateScreenWidth(48),
                            color: AppColors.systemBlackColor),
                      ),
                      UIHelper.verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Введите дополнительные данные о вашей организации. Чтобы мы могли показать его клиентам',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(24),
                            color: AppColors.systemDarkGrayColor,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: CustomContainer(
                          child: TextField(
                            controller: model.nameOfOrganizationController,
                            onChanged: (String value) {
                              model.checkForm();
                            },
                            keyboardType: TextInputType.text,
                            cursorColor: AppColors.systemBlackColor,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.group,
                                  color: AppColors.primaryColor),
                              hintText: 'Name of Organization',
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(40),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            value: model.choosedCard,
                            items: model.bankCardTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              model.chooseCard(value ?? "Kaspi");
                            }),
                      ),
                      UIHelper.verticalSpace(40),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(60)),
                        child: CustomContainer(
                          child: TextField(
                            controller: model.cardNumberController,
                            onChanged: (String value) {
                              model.checkForm();
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: AppColors.systemBlackColor,
                            inputFormatters: [model.cardNumberFormatter],
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.credit_card,
                                color: AppColors.primaryColor,
                              ),
                              hintText: 'Card number',
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(20),
                    ],
                  ),
                  floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("авторизоваться".toUpperCase())),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      DefaultButton(
                          width: model.size!.width * 0.9,
                          color: AppColors.primaryColor,
                          text: 'Дальше',
                          press: () {
                            model.toSendUpdate(context);
                          }),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                );
        }),
        model: AdditionalInfoFeelProvider());
  }
}
