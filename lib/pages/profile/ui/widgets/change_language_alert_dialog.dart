// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:kettik_business/base/base_provider.dart';
// import 'package:kettik_business/pages/profile/provider/lang_provider.dart';
// import 'package:kettik_business/widgets/default_button.dart';
// import 'package:kettik_business/widgets/loading_view.dart';

// import '../../../../shared/size_config.dart';
// import '../../../../shared/theme.dart';

// class ChangeLanguageAlertDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BaseProvider<LangProvider>(
//         model: LangProvider(),
//         onReady: (_) => _.init(context),
//         builder: (context, model, child) {
//           return model.isLoading
//               ? const LoadingView()
//               : Dialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   elevation: 0,
//                   alignment: Alignment.center,
//                   backgroundColor: AppColors.whiteColor,
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       top: getProportionateScreenHeight(60),
//                       bottom: getProportionateScreenHeight(60),
//                       left: getProportionateScreenWidth(120),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListView.separated(
//                           shrinkWrap: true,
//                           itemCount: model.langs.length,
//                           separatorBuilder: (_, index) => SizedBox(
//                             height: getProportionateScreenHeight(20),
//                           ),
//                           itemBuilder: (_, index) => GestureDetector(
//                             onTap: () =>
//                                 model.changeLangByIndex(context, index),
//                             child: Container(
//                               color: AppColors.primaryColor.withOpacity(0),
//                               child: ListTile(
//                                 onTap: () async {
//                                   model.changeLangByIndex(context, index);
//                                   // await model.applyChoosedLang(context);
//                                 },
//                                 title: Text(
//                                   model.langs[index],
//                                 ),
//                                 trailing: Radio<String>(
//                                   activeColor: AppColors.primaryColor,
//                                   value: model.langs[index],
//                                   groupValue: model.langGroupValue,
//                                   onChanged: (value) async {
//                                     model.changeLangByIndex(context, index);
//                                     // await model.applyChoosedLang(context);
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         DefaultButton(
//                           press: () async {
//                             await model.applyChoosedLang(context);
//                           },
//                           text: "Apply",
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//         });
//   }
// }
