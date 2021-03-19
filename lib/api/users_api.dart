import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:daftar_gerobak/model/user.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  static Future<List<User>> getUsers() async {
    final url =
        'https://raw.githubusercontent.com/wienaamanda/json/main/daftar_gerobak.json';
    final response = await http.get(url);
    final body = json.decode(response.body);

    return body.map<User>(User.fromJson).toList();
  }
}
