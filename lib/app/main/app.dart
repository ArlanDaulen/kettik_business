import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kettik_business/app/main/app_model.dart';
import 'package:kettik_business/app/main/navigator_state.dart';
import 'package:kettik_business/app/main/no_internet_screen.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/shared/theme.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;

  MyApp({required this.model});

  @override
  Widget build(BuildContext context) {
    return BaseProvider<MyAppModel>(
      model: model,
      builder: (context, model, child) {
        return StreamBuilder<Object>(
          stream: model.connectionStatusController.stream,
          builder: (context, snapshot) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: 'Kettik',
              navigatorKey: GlobalVariable.navState,
              theme: ThemeData(
                primaryColor: AppColors.primaryColor,
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: AppColors.primaryColor.withOpacity(0),
                ),
                // backgroundColor: Colors.white,
                fontFamily: 'Manrope',
              ),
              home: snapshot.data == ConnectivityResult.none ||
                      snapshot.data == null
                  ? const NoInternetScreen()
                  : model.getHomeScreen(),
            );
          },
        );
      },
    );
  }
}
