import 'package:society_managment/data/models/user_model.dart';

class LoginModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? occupation;
  final String? age;
  final int? villageId;
  final int? cityId;
  final String? address;
  final String? accessToken;

  LoginModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.occupation,
    this.age,
    this.villageId,
    this.cityId,
    this.address,
    this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"] is int ? json["id"] as int : int.tryParse('${json["id"]}'),
    name: json["name"]?.toString(),
    email: json["email"]?.toString(),
    phone: json["phone"]?.toString(),
    avatar: json["avatar"]?.toString(),
    occupation: json["occupation"]?.toString(),
    age: json["age"]?.toString(),
    villageId: json["village_id"] is int
        ? json["village_id"] as int
        : int.tryParse('${json["village_id"]}'),
    cityId: json["city_id"] is int
        ? json["city_id"] as int
        : int.tryParse('${json["city_id"]}'),
    address: json["address"]?.toString(),
    accessToken: json["access_token"]?.toString(),
  );

  UserModel toUserModel() => UserModel(
    id: id?.toString(),
    name: name,
    email: email,
    phone: phone,
    image: avatar,
    occupation: occupation,
    age: age,
    village: villageId?.toString(),
    address: address,
    city: cityId?.toString(),
  );
}
