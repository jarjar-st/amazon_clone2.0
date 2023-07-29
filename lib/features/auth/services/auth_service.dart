import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      print(user.name);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("antes del erro handler ${res.body}");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Cuenta creada");
        },
      );
    } catch (e) {
      print("Entra");
      showSnackBar(context, e.toString());
    }
  }
}
