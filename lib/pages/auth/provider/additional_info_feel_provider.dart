import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/index/ui/index.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AdditionalInfoFeelProvider extends BaseBloc {
  Size? size;
  TextEditingController nameOfOrganizationController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();

  var cardNumberFormatter = MaskTextInputFormatter(
    mask: '####-####-####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String choosedCard = "Kaspi";
  List<String> bankCardTypes = ["Kaspi", "Halyk"];

  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;

    setLoading(false);
  }

  chooseCard(String value) {
    choosedCard = value;
    notifyListeners();
  }

  void toSendUpdate(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const IndexScreen()));
  }

  void checkForm() {}
}
