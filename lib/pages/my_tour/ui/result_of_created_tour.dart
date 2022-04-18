import 'package:flutter/material.dart';
import 'package:kettik_business/pages/index/ui/index.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';

class ResultOfCreatedTourScreen extends StatelessWidget {
  const ResultOfCreatedTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.check,
                color: AppColors.systemGreenColor,
                size: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ваш тур успешно создан!",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Поздравляем!",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DefaultButton(
          press: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const IndexScreen()),
                (route) => false);
          },
          text: "На главную",
          width: MediaQuery.of(context).size.width * 0.9),
    );
  }
}
