import 'dart:developer';

import 'package:medhanite_registration/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../state_enum.dart';

Future<state> checkLoginFunc() async {
  // /admins
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();

  String _token = _sharedPreferences.getString("token");

  print("+++++++++++++++++++++++++++++++");
  if (_token == null) return state.unAuthenticated;

  http.Response res = await http.get(Uri.parse(url + 'admins/validate'),
      headers: {"Authorization": "Bearer $_token"});
  log(res.body);
  if (res.statusCode >= 200 && res.statusCode < 300)
    return state.authenticated;
  else
    return state.unAuthenticated;
}
