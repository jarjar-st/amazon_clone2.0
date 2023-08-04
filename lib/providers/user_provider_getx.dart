import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<User> _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  ).obs;

  User get user => _user.value;

  void setUser(String user) {
    _user.value = User.fromJson(user);
  }

  void setUserFromModel(User user) {
    _user.value = user;
  }
}
