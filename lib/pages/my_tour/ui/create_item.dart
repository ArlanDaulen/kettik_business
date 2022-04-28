import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_item_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_item_provider.dart';
import 'package:kettik_business/widgets/default_button.dart';

class CreateItemScreen extends StatelessWidget {
  final AddItemProvider addItemProvider;
  const CreateItemScreen({Key? key, required this.addItemProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<CreateItemProvider>(
        onReady: (_) => _.init(context),
        builder: ((context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Создать item"),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: model.controller,
                    decoration: InputDecoration(
                        hintText: "Name of item",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    press: () {},
                    text: "Create",
                    width: model.size!.width,
                  )
                ],
              ),
            ),
          );
        }),
        model: CreateItemProvider());
  }
}
