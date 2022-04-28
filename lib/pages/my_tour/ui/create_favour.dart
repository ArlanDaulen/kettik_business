import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_favour_provider.dart';

class CreateFavourScreen extends StatelessWidget {
  const CreateFavourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<CreateFavourProvider>(
        onReady: (_) => _.init(context),
        builder: ((context, model, child) {
          return Scaffold();
        }),
        model: CreateFavourProvider());
  }
}
