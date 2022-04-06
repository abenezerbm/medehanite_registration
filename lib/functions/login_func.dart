import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

Future login(String userName, String password) async {
  http.Response res = await http.post(Uri.parse(url + "admins/auth"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({"email": userName, "password": password}));
  log(res.body);

  if (res.statusCode >= 200 && res.statusCode < 300) {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString('token', jsonDecode(res.body)['token']);
  } else
    throw ("");
}
