import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:medhanite_registration/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Uint8List> getImage(String path) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  http.Response res = await http.get(Uri.parse(url + 'admins/image?url=$path'),
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString("token")}"
      });

  if (res.statusCode == 200) return base64Decode(jsonDecode(res.body)['image']);
  throw ("");
}
