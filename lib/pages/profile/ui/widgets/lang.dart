import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/pages/profile/provider/lang_provider.dart';
import 'package:kettik_business/pages/profile/provider/profile_provider.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';

import '../../../../base/base_provider.dart';
import '../../../../widgets/loading_view.dart';

class LangWidget extends StatelessWidget {
  final ProfileProvider profileProvider;
  const LangWidget({Key? key, required this.profileProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<LangProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return model.isLoading
              ? LoadingView()
              : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(50),
                      vertical: getProportionateScreenHeight(50)),
                  width: model.size!.width,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "changeLang".tr(),
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(33)),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        itemCount: model.langs.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: AppColors.systemDarkGrayColor,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              model.changeLangByIndex(context, index);
                            },
                            title: Text(
                              model.langs[index],
                            ),
                            trailing: Radio<String>(
                                value: model.langs[index],
                                groupValue: model.langGroupValue,
                                onChanged: (value) {
                                  model.changeLangByIndex(context, index);
                                }),
                          );
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      DefaultButton(
                        text: "apply".tr().toUpperCase(),
                        color: AppColors.primaryColor,
                        press: () async {
                          await model.applyChoosedLang(
                              context, profileProvider);
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                    ],
                  ),
                );
        },
        model: LangProvider());
  }
}
