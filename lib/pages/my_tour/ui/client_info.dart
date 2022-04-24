import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik_business/app/data/models/client_model.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/my_tour/provider/client_info_provider.dart';
import 'package:kettik_business/pages/profile/ui/widgets/user_info.dart';
import 'package:kettik_business/shared/size_config.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientInfoScreen extends StatelessWidget {
  final ClientModel client;
  const ClientInfoScreen({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<ClientInfoProvider>(
        onReady: (_) => _.init(context),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Client"),
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: model.size!.width,
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppSvgImages.avatar_ic,
                          height: getProportionateScreenHeight(242),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              client.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenHeight(30),
                              ),
                            ),
                            Text(
                              client.phone!,
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(24),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        DefaultButton(
                          text: "WhatsApp",
                          press: () async {
                            if (await canLaunch(
                                "https://wa.me/${client.phone}")) {
                              await launch("https://wa.me/${client.phone}");
                            } else {
                              _showAlertCantOpenWhatsappOrPhone(context);
                            }
                          },
                          color: AppColors.systemGreenColor,
                        ),
                        const SizedBox(height: 10),
                        DefaultButton(
                          text: "Позвонить",
                          press: () async {
                            if (await canLaunch("tel://${client.phone}")) {
                              await launch("tel://${client.phone}");
                            } else {
                              _showAlertCantOpenWhatsappOrPhone(context);
                            }
                          },
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    // name
                    // avatar
                    // phone
                    // mail
                  ],
                ),
              ),
            ),
          );
        },
        model: ClientInfoProvider());
  }
}

_showAlertCantOpenWhatsappOrPhone(BuildContext context) {
  return CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      title: "Извините.",
      text: "Мы не можем открыть, введите номер вручную! Спасибо!)");
}

_buildMessangerPhones(Widget icon, String phone) {
  return Row(
    children: [
      icon,
      SizedBox(
        width: getProportionateScreenWidth(25),
      ),
      Text(
        phone,
        style: TextStyle(
          fontSize: getProportionateScreenHeight(24),
        ),
      ),
    ],
  );
}
