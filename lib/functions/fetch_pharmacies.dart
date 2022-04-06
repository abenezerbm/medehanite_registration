import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medhanite_registration/list_of_pharmacies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

Future<PharmaciesModel> fetchPharmacies({int page=1}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${sharedPreferences.getString("token")}',
    'Content-Type': 'application/json'
  };
  var request = http.Request('GET', Uri.parse('${url}user/medicalCenters?page=$page'));
  request.body = '''{\n    "type":["Pharmacy"]\n}''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  

  if (response.statusCode == 200) {

    
    return pharmaciesModelFromJson(await response.stream.bytesToString());
  } else {
if (response.statusCode == 401)
      throw ("Unauthenticated");
    else
      throw ("");
  }
}
