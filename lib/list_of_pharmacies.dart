import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medhanite_registration/functions/fetch_pharmacies.dart';
import 'package:medhanite_registration/functions/get_image.dart';
import 'package:medhanite_registration/list_of_pharmacies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOfPharmacies extends StatefulWidget {
  @override
  _ListOfPharmaciesState createState() => _ListOfPharmaciesState();
}

class _ListOfPharmaciesState extends State<ListOfPharmacies> {
  ScrollController scrollController;
  PharmaciesModel pharmaciesModel;
  bool loading = false;
  bool hasError = false;

  bool fetchingFiles = false;
  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        loading = true;
        setState(() {});
        pharmaciesModel = await fetchPharmacies();
        loading = false;
        setState(() {});
      } catch (e) {

        print(e.stackTrace);
        hasError = true;
        loading = false;
        setState(() {});

        if (e == "Unauthenticated") {
          SharedPreferences.getInstance()
              .then((value) => value.remove("token"));
          Navigator.pushNamedAndRemoveUntil(
              context, "/", (route) => route.settings.name == '/');
        }
      }

      scrollController.addListener(() async {
        if ((scrollController.position.maxScrollExtent -
                        scrollController.position.pixels <
                    500 ||
                scrollController.position.atEdge) &&
            !loading) {
          if (pharmaciesModel.nextPageUrl != null) {
            try {
              loading = true;
              setState(() {});
              PharmaciesModel p =
                  await fetchPharmacies(page: pharmaciesModel.currentPage + 1);
              pharmaciesModel.data.addAll(p.data);
              pharmaciesModel.currentPage = p.currentPage;
              pharmaciesModel.nextPageUrl = p.nextPageUrl;
              loading = false;
              setState(() {});
            } catch (e) {
              loading = false;
              setState(() {});
              if (e == "Unauthenticated") {
                SharedPreferences.getInstance()
                    .then((value) => value.remove("token"));
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => route.settings.name == '/');
              }
            }
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacies"),
      ),
      body: Stack(
        children: [
          ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: scrollController,
            children: [
              if (pharmaciesModel == null && loading)
                Center(child: CircularProgressIndicator()),
              if (pharmaciesModel != null &&
                  (pharmaciesModel.data ?? []).isNotEmpty)
                for (Datum d in pharmaciesModel.data)
                  ListTile(
                    onTap: () async {
                      try {
                        // fetchingFiles = true;
                        // setState(() {});
                        // Uint8List businessLicense =
                        //     await getImage(d.businessLicense);
                        // Uint8List tinNumber = await getImage(d.tinNumber);
                        // Uint8List medicalLicense = await getImage(d.medicalLicense);

                        // fetchingFiles = false;
                        // setState(() {});

                        Navigator.pushNamed(context, 'formScreen', arguments: {
                          "datum": d,
                          // "businessLicense": businessLicense,
                          // 'tinNumber': tinNumber,
                          // 'medicalLicense': medicalLicense,
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Network error, try again"),
                          behavior: SnackBarBehavior.floating,
                        ));
                        fetchingFiles = false;
                        setState(() {});
                        print(e);
                      }
                      // Navigator.pushNamed(context, 'formScreen', arguments: d);
                    },
                    title: Text(d.name ?? ""),
                    subtitle: Text(d.relativeLocation ?? ""),
                  ),
              if (pharmaciesModel != null && loading)
                Center(child: CircularProgressIndicator()),
              if (pharmaciesModel == null && hasError)
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          try {
                            loading = true;
                            setState(() {});
                            pharmaciesModel = await fetchPharmacies();

                            loading = false;
                            setState(() {});
                          } catch (e) {
                            hasError = true;
                            loading = false;
                            setState(() {});
                          }
                        }),
                    Text("Reload"),
                  ],
                )
            ],
          ),
          if (fetchingFiles)
            Container(
                color: Colors.white.withOpacity(0.2),
                child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}
