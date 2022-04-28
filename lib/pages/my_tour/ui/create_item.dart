import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_item_provider.dart';

class CreateItemScreen extends StatelessWidget {
  const CreateItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<CreateItemProvider>(
        onReady: (_) => _.init(context),
        builder: ((context, model, child) {
          return Scaffold();
        }),
        model: CreateItemProvider());
  }
}
