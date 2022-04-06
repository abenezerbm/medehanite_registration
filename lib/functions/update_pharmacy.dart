import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:medhanite_registration/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future updatePharmacy(String id,
    {String name,
    String city,
    String location,
    String email,
    // File nigedFekad,
    // File tin,
    // File tenaTibeka,
    LocationData locationData}) async {
  print("*************          *******************");

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  http.MultipartRequest multipartRequest = http.MultipartRequest(
      "POST", Uri.parse(url + 'admins/medicalCenters/$id/update'));

  // if (nigedFekad != null)
  //   multipartRequest.files.add(
  //       await http.MultipartFile.fromPath("businessLicense", nigedFekad.path));
  // if (tin != null)
  //   multipartRequest.files
  //       .add(await http.MultipartFile.fromPath("tinNumber", tin.path));
  // if (tenaTibeka != null)
  //   multipartRequest.files.add(
  //       await http.MultipartFile.fromPath("medicalLicense", tenaTibeka.path));

  multipartRequest.fields.addAll({
    'name': name,
    'relativeLocation': location,
    'longitude': locationData.longitude.toString(),
    'latitude': locationData.latitude.toString(),
    'city': city,
    'type': "Pharmacy",
  });

  if (email != null) multipartRequest.fields.addAll({'email': email});

  multipartRequest.headers.addAll({
    'Accept': 'application/json',
    'Authorization': 'Bearer ${sharedPreferences.getString("token")}'
  });

  http.StreamedResponse response = await multipartRequest.send();
  log(await response.stream.bytesToString());

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return;
  } else {
    if (response.statusCode == 401)
      throw ("Unauthenticated");
    else
      throw ("");
  }
}
