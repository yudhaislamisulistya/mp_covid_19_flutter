import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:status_alert/status_alert.dart';

class AdminChangeSpotScreen extends StatefulWidget {
  final int id;
  final String name;
  final String address;
  final String city;
  final String longitude;
  final String latitude;
  AdminChangeSpotScreen({this.id, this.name, this.address, this.city, this.longitude, this.latitude});
  @override
  _AdminChangeSpotScreenState createState() => _AdminChangeSpotScreenState();
}

class _AdminChangeSpotScreenState extends State<AdminChangeSpotScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();


  _changeDataSpot(name, address, city, longitude, latitude) async {
    print("Tombol Ubah Berhasil di Tekan");
    String url =
        'https://mp-covid19-api.000webhostapp.com/public/api/spot/${widget.id}/update';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"name": "$name", "address": "$address", "city": "$city", "longitude": "$longitude", "latitude": "$latitude"}';
    print(url);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: KBackgroundColorSecondary,
      appBar: new AppBar(
        title: new Text("Ubah Data"),
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
                    initialValue: widget.name,
                    decoration: InputDecoration(labelText: "Nama Posko"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "address",
                    initialValue: widget.address,
                    decoration:
                    InputDecoration(labelText: "Alamat Posko"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "city",
                    initialValue: widget.city,
                    decoration: InputDecoration(labelText: "Kota"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "longitude",
                    initialValue: widget.longitude,
                    decoration: InputDecoration(labelText: "Longitude"),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "latitude",
                    initialValue: widget.latitude,
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
                            _changeDataSpot(
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
