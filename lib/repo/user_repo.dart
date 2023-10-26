import 'dart:convert';

import 'package:employeeapp/model/user_model.dart';
import 'package:http/http.dart';

class UserRepo {
  String userUrl = 'https://reqres.in/api/users?page=2';

  Future<List<UserModel>> getUser() async {
    Response response = await get(Uri.parse(userUrl));
    if (response.statusCode == 200) {
      print("response $response");
      print("API Response: ${response.body}");

      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}