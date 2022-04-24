import 'package:flutter/material.dart';
import 'package:kettik_business/pages/home/ui/home.dart';
import 'package:kettik_business/pages/profile/ui/profile.dart';
import 'package:kettik_business/pages/tickets/ui/tickets.dart';
import 'package:kettik_business/widgets/custom_app_bar.dart';
import 'package:kettik_business/widgets/loading_view.dart';

import '../../../base/base_provider.dart';
import '../../../shared/size_config.dart';
import '../../../shared/theme.dart';
import '../../my_tour/ui/my_tour.dart';
import '../provider/index_provider.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<IndexProvider>(
      onReady: (p0) => p0.init(context),
      model: IndexProvider(),
      builder: (context, model, child) {
        return model.isLoading
            ? const LoadingView()
            : Scaffold(
                body: _body[model.bottomIndex],
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: AppColors.primaryColor,
                  selectedFontSize: getProportionateScreenHeight(24),
                  unselectedFontSize: getProportionateScreenHeight(20),
                  unselectedItemColor: AppColors.systemBlackColor,
                  showUnselectedLabels: true,
                  currentIndex: model.bottomIndex,
                  items: model.items!,
                  onTap: (index) => model.setBottomIndex(index),
                ),
              );
      },
    );
  }
}

var _body = [
  const HomeScreen(),
  const MyTourScreen(),
  const TicketsScreen(),
  const ProfileScreen(),
];
