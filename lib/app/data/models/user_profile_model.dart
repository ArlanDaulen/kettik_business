class UserProfile {
  int? id;
  String? email;
  String? fullName;
  String? phone;
  String? telegramPhone;
  String? whatsappPhone;

  UserProfile(
      {this.id,
      this.email,
      this.fullName,
      this.phone,
      this.telegramPhone,
      this.whatsappPhone});

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
}
