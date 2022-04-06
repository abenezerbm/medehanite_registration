import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:medhanite_registration/functions/create_pharmacy.dart';
import 'package:medhanite_registration/functions/get_location.dart';
import 'package:medhanite_registration/functions/image_picker.dart';
import 'package:medhanite_registration/list_of_pharmacies_model.dart';
import 'package:medhanite_registration/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions/update_pharmacy.dart';

class FormScreen extends StatefulWidget {
  final Datum datum;

  // final Uint8List businessLicense;
  // final Uint8List tinNumber;
  // final Uint8List medicalLicense;

  const FormScreen({
    Key key,
    this.datum,
    // this.businessLicense,
    // this.tinNumber,
    // this.medicalLicense
  }) : super(key: key);
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController;
  TextEditingController cityController;
  TextEditingController locationController;
  TextEditingController emailController;

  File nigedFikad;
  File tinNumber;
  File tenaTibeka;

  Uint8List businessLicense;
  Uint8List tin;
  Uint8List medicalLicense;
  LocationData locationData;

  GlobalKey<FormState> _formKey;
  bool loading = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    cityController = TextEditingController();
    locationController = TextEditingController();
    emailController = TextEditingController();

    if (widget.datum != null) {
      nameController.text = widget.datum.name;
      cityController.text = widget.datum.city;
      locationController.text = widget.datum.relativeLocation;
      emailController.text = widget.datum.user.email;

      locationData = LocationData.fromMap({
        "latitude": widget.datum.latitude,
        "longitude": widget.datum.longitude
      });

      // businessLicense = widget.businessLicense;
      // tin = widget.tinNumber;
      // medicalLicense = widget.medicalLicense;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.pushNamed(context, 'listOfPharmacies');
              }),
          PopupMenuButton(
              onSelected: (v) {
                if (v != null && v) {
                  SharedPreferences.getInstance()
                      .then((value) => value.remove("token"));
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => route.settings.name == '/');
                }
              },
              child: Icon(Icons.logout),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Sign out"),
                      value: true,
                    ),
                  ])
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: outLineInputBorder(context),
                          focusedBorder: outLineInputBorder(context),
                          hintText: "Pharmacy X",
                          labelText: "Name"),
                      obscureText: false,
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: outLineInputBorder(context),
                          focusedBorder: outLineInputBorder(context),
                          hintText: "Addis Ababa",
                          labelText: "City"),
                      obscureText: false,
                      controller: cityController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: outLineInputBorder(context),
                          focusedBorder: outLineInputBorder(context),
                          hintText: "flamingo",
                          labelText: "Location"),
                      obscureText: false,
                      controller: locationController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: outLineInputBorder(context),
                          focusedBorder: outLineInputBorder(context),
                          hintText: "email@example.com",
                          labelText: "email"),
                      obscureText: false,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    nigedFikadBuilder(size),
                    tinNumberBuilder(size),
                    tenaTibekaBuilder(size),
                    OutlinedButton.icon(
                        onPressed: () async {
                          try {
                            locationData = await getLocation();

                            setState(() {});
                          } catch (e) {
                            showSnackBar("Failed, try again");
                          }
                        },
                        icon: Icon(Icons.location_on),
                        label: Text(locationData != null
                            ? "${locationData.latitude},${locationData.longitude} \naccuracy ${locationData.accuracy?.toStringAsFixed(2) ?? "**"}"
                            : "Location")),
                    TextButton(
                        onPressed: ()async {
                          if (_formKey.currentState.validate()) {
                            if (widget.datum == null) {
                              if (nigedFikad == null)
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Capture niged fikad"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ));
                              if (tinNumber == null)
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Capture Tin"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ));
                              if (tenaTibeka == null)
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Capture tena tibeka"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ));
                              if (locationData == null)
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Press location button"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ));

                              try {
                                loading = true;
                                setState(() {});
                               await  createPharmacy(
                                    city: cityController.text,
                                    email: emailController.text,
                                    location: locationController.text,
                                    name: nameController.text,
                                    locationData: locationData,
                                    nigedFekad: nigedFikad,
                                    tenaTibeka: tenaTibeka,
                                    tin: tinNumber);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Success"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 3),
                                ));

                                nameController.clear();
                                cityController.clear();
                                locationController.clear();
                                emailController.clear();
                                locationData = null;
                                nigedFikad = null;
                                tenaTibeka = null;
                                tinNumber = null;

                                loading = false;
                                setState(() {});
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Failed,  try again"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 1),
                                ));
                                loading = false;
                                setState(() {});

                                if (e == "Unauthenticated") {
                                  SharedPreferences.getInstance()
                                      .then((value) => value.remove("token"));
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      "/",
                                      (route) => route.settings.name == '/');
                                }
                              }
                            } else {
                              try {
                                loading = true;
                                setState(() {});
                          await       updatePharmacy(
                                  widget.datum.id,
                                  city: cityController.text,
                                  email: emailController.text.trim() ==
                                          widget.datum.user.email
                                      ? null
                                      : emailController.text.trim(),
                                  location: locationController.text,
                                  name: nameController.text,
                                  locationData: locationData,
                                  // nigedFekad: nigedFikad,
                                  // tenaTibeka: tenaTibeka,
                                  // tin: tinNumber
                                );
                                loading = false;
                                setState(() {});
                                if (widget.datum != null) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Failed,  try again"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 1),
                                ));
                                loading = false;
                                setState(() {});

                                if (e == "Unauthenticated") {
                                  SharedPreferences.getInstance()
                                      .then((value) => value.remove("token"));
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      "/",
                                      (route) => route.settings.name == '/');
                                }
                              }
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        child: Text(
                          widget.datum == null ? "Register" : "Update",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
          if (loading)
            Container(
                color: Colors.white.withOpacity(0.2),
                child: Center(
                  child: CircularProgressIndicator(),
                ))
        ],
      ),
    );
  }

  OutlineInputBorder outLineInputBorder(context) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Theme.of(context).primaryColor));

  showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget nigedFikadBuilder(Size size) {
    if (widget.datum != null) return Container();

    return Column(
      children: [
        if (nigedFikad != null)
          InkWell(
            onTap: () {
              showSnackBar("double tap to remove");
            },
            onDoubleTap: () {
              nigedFikad = null;
              setState(() {});
            },
            child: ClipRRect(
              child: Image.file(
                nigedFikad,
                width: min(300, size.width * 0.7),
              ),
            ),
          )
        else if (businessLicense != null)
          InkWell(
            onTap: () {
              showSnackBar("double tap to remove");
            },
            onDoubleTap: () {
              businessLicense = null;
              setState(() {});
            },
            child: ClipRRect(
              child: Image.memory(
                businessLicense,
                width: min(300, size.width * 0.7),
              ),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (nigedFikad == null && businessLicense == null)
          OutlinedButton.icon(
              onPressed: () async {
                try {
                  nigedFikad = await imagePicker(ImageSource.camera);

                  setState(() {});
                } catch (e) {
                  print(e);
                  showSnackBar("Failed, try again");
                }
              },
              icon: Icon(Icons.image),
              label: Text("Niged fikad")),
      ],
    );
  }

  Widget tinNumberBuilder(Size size) {
    if (widget.datum != null) return Container();

    return Column(
      children: [
        if (tinNumber != null)
          InkWell(
            onTap: () {
              showSnackBar("double tap to remove");
            },
            onDoubleTap: () {
              tinNumber = null;
              setState(() {});
            },
            child: Image.file(
              tinNumber,
              width: min(300, size.width * 0.7),
            ),
          )
        else if (tin != null)
          InkWell(
            onTap: () {
              showSnackBar("double tap to remove");
            },
            onDoubleTap: () {
              tin = null;
              setState(() {});
            },
            child: Image.memory(
              tin,
              width: min(300, size.width * 0.7),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (tinNumber == null && tin == null)
          OutlinedButton.icon(
              onPressed: () async {
                try {
                  tinNumber = await imagePicker(ImageSource.camera);

                  setState(() {});
                } catch (e) {
                  showSnackBar("Failed, try again");
                }
              },
              icon: Icon(Icons.image),
              label: Text("Tin")),
      ],
    );
  }

  Widget tenaTibekaBuilder(Size size) {
    if (widget.datum != null) return Container();
    return Column(
      children: [
        if (tenaTibeka != null)
          InkWell(
            onTap: () {
              showSnackBar("double tap to remove");
            },
            onDoubleTap: () {
              tenaTibeka = null;
              setState(() {});
            },
            child: Image.file(
              tenaTibeka,
              width: min(300, size.width * 0.7),
            ),
          )
        else if (medicalLicense != null)
          InkWell(
            onTap: () {
              showSnackBar("double tap to remove");
            },
            onDoubleTap: () {
              medicalLicense = null;
              setState(() {});
            },
            child: Image.memory(
              medicalLicense,
              width: min(300, size.width * 0.7),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (tenaTibeka == null && medicalLicense == null)
          OutlinedButton.icon(
              onPressed: () async {
                try {
                  tenaTibeka = await imagePicker(ImageSource.camera);

                  setState(() {});
                } catch (e) {
                  showSnackBar("Failed, try again");
                }
              },
              icon: Icon(Icons.image),
              label: Text("Tena tibeka")),
      ],
    );
  }
}
