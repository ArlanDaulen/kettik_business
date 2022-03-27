import 'dart:io';

class UserProfile {
  int? id;
  String? email;
  String? fullName;
  String? phone;
  String? telegramPhone;
  String? whatsappPhone;
  File? image;

  UserProfile(
      {this.id,
      this.email,
      this.fullName,
      this.phone,
      this.telegramPhone,
      this.whatsappPhone,
      this.image});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    telegramPhone = json['telegramPhone'];
    whatsappPhone = json['whatsappPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['telegramPhone'] = this.telegramPhone;
    data['whatsappPhone'] = this.whatsappPhone;
    return data;
  }

  UserProfile copyWith({
    String? email,
    String? fullName,
    String? telegramPhone,
    String? whatsappPhone,
    File? image,
  }) =>
      UserProfile(
        id: id,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        phone: phone,
        telegramPhone: telegramPhone ?? this.telegramPhone,
        whatsappPhone: whatsappPhone ?? this.whatsappPhone,
        image: image ?? this.image!,
      );
}
