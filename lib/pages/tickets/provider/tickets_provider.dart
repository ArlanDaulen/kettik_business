import 'package:flutter/material.dart';
import 'package:kettik_business/app/data/models/ticket_model.dart';
import 'package:kettik_business/base/base_bloc.dart';
import 'package:kettik_business/pages/my_tour/ui/add_place.dart';
import 'package:kettik_business/pages/my_tour/ui/create_tour.dart';

class TicketsProvider extends BaseBloc {
  Size? size;
  init(BuildContext context) {
    setLoading(true);
    size = MediaQuery.of(context).size;
    setLoading(false);
  }

  List<TicketModel> tickets = [
    TicketModel(
        id: 1,
        tourName: "Озеро Иссык",
        status: "В ОЖИДАНИИ",
        nameOfClient: "Bahtiyar",
        organiztaorId: 1,
        fromDate: "12.07",
        toDate: "13.07"),
    TicketModel(
        id: 1,
        tourName: "Светилище мерке",
        status: "В ОЖИДАНИИ",
        nameOfClient: "Aliomar",
        organiztaorId: 1,
        fromDate: "12.07",
        toDate: "13.07"),
    TicketModel(
        id: 1,
        tourName: "Каркаралы",
        status: "В ОЖИДАНИИ",
        nameOfClient: "Erasyl",
        organiztaorId: 1,
        fromDate: "13.07",
        toDate: "13.07"),
    TicketModel(
        id: 1,
        tourName: "Боровое",
        status: "В ОЖИДАНИИ",
        nameOfClient: "Nurgeldy",
        organiztaorId: 1,
        fromDate: "12.07",
        toDate: "13.07"),
    TicketModel(
        id: 1,
        tourName: "Зеренда",
        status: "В ОЖИДАНИИ",
        nameOfClient: "Jan Fresko",
        organiztaorId: 1,
        fromDate: "12.07",
        toDate: "13.07"),
    TicketModel(
        id: 1,
        tourName: "Катон-Карагай",
        status: "В ОЖИДАНИИ",
        nameOfClient: "Bahtiyar",
        organiztaorId: 1,
        fromDate: "12.07",
        toDate: "13.07"),
  ];

  void acceptTicket(int index) {
    //TODO request to change status payed
    tickets.removeAt(index);
    notifyListeners();
  }

  void cancelTicket(int index) {
    //TODO request to change status cancel
    tickets.removeAt(index);
    notifyListeners();
  }

  void navigateToCreateTourScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddPlaceScreen()));
  }
}
