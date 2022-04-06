import 'package:flutter/material.dart';
import 'package:medhanite_registration/check_auth.dart';

import 'form.dart';
import 'list_of_pharmacies.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    onGenerateRoute: (RouteSettings settings) {
      if (settings.name == 'login')
        return MaterialPageRoute(builder: (context) => Login());
      if (settings.name == 'formScreen')
        return MaterialPageRoute(
            builder: (context) => settings.arguments ==null ? FormScreen():FormScreen(
                datum: (settings.arguments as Map)['datum'],
                // businessLicense: (settings.arguments as Map)['businessLicense'],
                // tinNumber: (settings.arguments as Map)['tinNumber'],
                // medicalLicense: (settings.arguments as Map)['medicalLicense']
                )
                
                );
      if (settings.name == 'listOfPharmacies')
        return MaterialPageRoute(builder: (context) => ListOfPharmacies());

      return MaterialPageRoute(builder: (context) => CheckAuth());
    },
    title: 'Flutter Demo',
    theme: ThemeData(
      primaryColor: Color.fromRGBO(20, 170, 187, 1),
      backgroundColor: Colors.white,
      accentColor: Color.fromRGBO(255, 125, 139, 1),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: CheckAuth(),
  ));
}
