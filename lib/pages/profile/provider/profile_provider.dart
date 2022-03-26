import 'package:flutter/cupertino.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/shared/size_config.dart';

import '../../../app/data/models/user_profile_model.dart';

class ProfileProvider extends BaseBloc {
  final UserProfile user = UserProfile(
    id: 1,
    fullName: 'Amangeldi Spatay',
    email: 'arlanvladelets@gmail.com',
    phone: '+7 (705) 278-07-38',
    telegramPhone: '+7 (705) 278-07-38',
    whatsappPhone: '+7 (705) 278-07-38',
  );

  init(BuildContext context) {
    setLoading(true);
    SizeConfig().init(context);
    setLoading(false);
  }
}
