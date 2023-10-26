import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? avatar;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['avatar'] = avatar;

    return data;
  }
}


// class UserModel {
//   int? id;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? avatar;

//   UserModel({this.id, this.email, this.firstName, this.lastName, this.avatar});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     email = json['email'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     avatar = json['avatar'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['email'] = this.email;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['avatar'] = this.avatar;
//     return data;
//   }
// }
