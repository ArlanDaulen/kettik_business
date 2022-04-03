import 'package:flutter/cupertino.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/shared/size_config.dart';

class HomeProvider extends BaseBloc {
  init(BuildContext context) {
    setLoading(true);
    SizeConfig().init(context);
    setLoading(false);
  }
}
