import 'package:kettik_business/core/network/interfaces/base_network_model.dart';

class UserAuthResponseModel extends BaseNetworkModel<UserAuthResponseModel> {
  int? id;
  User? user;
  String? token;
  int? expiryDate;

  UserAuthResponseModel({this.id, this.user, this.token, this.expiryDate});

  UserAuthResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['expiryDate'] = this.expiryDate;
    return data;
  }

  @override
  UserAuthResponseModel fromJson(Map<String, dynamic> json) {
    return UserAuthResponseModel.fromJson(json);
  }
}

class User {
  int? id;
  String? email;
  String? fullName;
  String? phone;

  User({this.id, this.email, this.fullName, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    return data;
  }
}
