import 'package:flutter/material.dart';
import 'package:kettik_business/base/base_provider.dart';
import 'package:kettik_business/pages/tickets/provider/tickets_provider.dart';
import 'package:kettik_business/shared/theme.dart';
import 'package:kettik_business/widgets/default_button.dart';
import 'package:kettik_business/widgets/loading_view.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider<TicketsProvider>(
        onReady: (_) => _.init(context),
        builder: ((context, model, child) {
          return model.isLoading
              ? const LoadingView()
              : Scaffold(
                  appBar: AppBar(
                    foregroundColor: AppColors.whiteColor,
                    backgroundColor: AppColors.primaryColor,
                    centerTitle: true,
                    title: const Text("Tour requests"),
                  ),
                  backgroundColor: Colors.black.withOpacity(0.05),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Здесь отображаются заявки на туры!",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          model.tickets.isEmpty
                              ?
                              //TODO here empty tickets icon
                              SizedBox(
                                  width: model.size!.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      //image
                                      SizedBox(height: 100),
                                      Icon(
                                        Icons.rocket_launch,
                                        color: AppColors.systemRedColor,
                                        size: 150,
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        "Заявок пока что нет.",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Давайте создадим новый тур!",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ))
                              : //TODO grouped list tickets
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  itemCount: model.tickets.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        decoration: const BoxDecoration(),
                                        child: Card(
                                          elevation: 9,
                                          child: Row(children: [
                                            Container(
                                              width: model.size!.width * 0.85,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "In process",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  _getRowInfoBuilder(
                                                      "#${model.tickets[index].id}",
                                                      model.tickets[index]
                                                              .tourName ??
                                                          ""),
                                                  _getRowInfoBuilder(
                                                      "Client:",
                                                      model.tickets[index]
                                                              .nameOfClient ??
                                                          ""),
                                                  _getRowInfoBuilder(
                                                      "Status:",
                                                      model.tickets[index]
                                                              .status ??
                                                          ""),
                                                  _getRowInfoBuilder(
                                                      "Tour dates:",
                                                      model.tickets[index]
                                                              .fromDate! +
                                                          " - " +
                                                          model.tickets[index]
                                                              .toDate!),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: DefaultButton(
                                                            press: () {
                                                              model
                                                                  .cancelTicket(
                                                                      index);
                                                            },
                                                            text: "Отклонить",
                                                            color: AppColors
                                                                .systemLightGrayColor,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: DefaultButton(
                                                            press: () {
                                                              model
                                                                  .acceptTicket(
                                                                      index);
                                                            },
                                                            text: "Оплатил",
                                                            color: Colors.green
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        )
                                                      ]),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                        ));
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                );
        }),
        model: TicketsProvider());
  }
}

_getRowInfoBuilder(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 4, right: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
