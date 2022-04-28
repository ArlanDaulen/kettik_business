import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';

class CreateItemProvider extends BaseBloc {
  Size? size;

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    setLoading(false);
  }
}
