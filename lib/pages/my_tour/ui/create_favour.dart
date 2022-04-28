import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/add_favour_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/create_favour_provider.dart';
import 'package:kettik_business/widgets/default_button.dart';

class CreateFavourScreen extends StatelessWidget {
  final AddFavourProvider addFavourProvider;
  const CreateFavourScreen({Key? key, required this.addFavourProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<CreateFavourProvider>(
        onReady: (_) => _.init(context),
        builder: ((context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Создать услугу"),
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
                        hintText: "Name of service type",
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
        model: CreateFavourProvider());
  }
}
