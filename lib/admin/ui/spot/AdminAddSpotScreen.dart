import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:status_alert/status_alert.dart';

class AdminAddSpotScreen extends StatefulWidget {
  @override
  _AdminAddSpotScreenState createState() => _AdminAddSpotScreenState();
}

class _AdminAddSpotScreenState extends State<AdminAddSpotScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  _addDataSpot(name, address, city, longitude, latitude) async {
    print("Tombol Tambah Berhasil di Tekan");
    String url =
        'https://mp-covid19-api.000webhostapp.com/public/api/spot/save';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"name": "$name", "address": "$address", "city": "$city", "longitude": "$longitude", "latitude": "$latitude"}';
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: KBackgroundColorSecondary,
      appBar: new AppBar(
        title: new Text("Tambah Data"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            padding: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: new FormBuilder(
              key: _fbKey,
              readOnly: false,
              child: new Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(labelText: "Nama Posko"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "address",
                    decoration:
                    InputDecoration(labelText: "Alamat Posko"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "city",
                    decoration: InputDecoration(labelText: "Kota"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "longitude",
                    decoration: InputDecoration(labelText: "Longitude"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "latitude",
                    decoration: InputDecoration(labelText: "Latitude"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          "Submit",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: kPrimaryColor,
                        onPressed: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            _addDataSpot(
                              _fbKey.currentState.value["name"],
                              _fbKey.currentState.value["address"],
                              _fbKey.currentState.value["city"],
                              _fbKey.currentState.value["longitude"],
                              _fbKey.currentState.value["latitude"],
                            );

                            StatusAlert.show(
                              context,
                              duration: Duration(seconds: 2),
                              title: 'Data Berhasil di Ditambahkan',
                              configuration: IconConfiguration(
                                icon: Icons.done,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        child: Text(
                          "Reset",
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.grey,
                        onPressed: () {
                          _fbKey.currentState.reset();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
