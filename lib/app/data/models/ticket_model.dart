class TicketModel {
  int? id;
  int? organiztaorId;
  String? tourName;
  String? nameOfClient;
  String? fromDate;
  String? toDate;
  String? status;

  TicketModel(
      {this.id,
      this.nameOfClient,
      this.organiztaorId,
      this.tourName,
      this.fromDate,
      this.toDate,
      this.status});
}
