import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:status_alert/status_alert.dart';

class AdminChangeCasesScreen extends StatefulWidget {
  final int id;
  final int confirmed_cases;
  final int total_deaths;
  final int total_recovered;
  final int new_cases;
  final String date;
  AdminChangeCasesScreen({this.id, this.confirmed_cases, this.total_deaths, this.total_recovered, this.new_cases, this.date});
  @override
  _AdminChangeCasesScreenState createState() => _AdminChangeCasesScreenState();
}

class _AdminChangeCasesScreenState extends State<AdminChangeCasesScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  _changeDataCases(
      confirmedCases, totalDeaths, totalRecovered, newCases, date) async {
    print("Tombol Tambah Berhasil di Tekan");
    String url =
        'https://mp-covid19-api.000webhostapp.com/public/api/case/${widget.id}/update';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"confirmed_cases": $confirmedCases, "total_deaths": $totalDeaths, "total_recovered": $totalRecovered, "new_cases": $newCases, "date": "$date"}';
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
                    attribute: "terkonfirmasi",
                    initialValue: widget.confirmed_cases.toString(),
                    decoration: InputDecoration(labelText: "Terkonfirmasi"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "kematian",
                    initialValue: widget.total_deaths.toString(),
                    decoration: InputDecoration(labelText: "kematian"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "sembuh",
                    initialValue: widget.total_recovered.toString(),
                    decoration: InputDecoration(labelText: "Sembuh"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "kasus_baru",
                    initialValue: widget.new_cases.toString(),
                    decoration: InputDecoration(labelText: "Kasus Baru"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                  FormBuilderDateTimePicker(
                    attribute: "date",
                    inputType: InputType.date,
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(labelText: "Tanggal Hari Ini"),
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
                          print(_fbKey.currentState.value["date"]);
                          if (_fbKey.currentState.saveAndValidate()) {
                            _changeDataCases(
                              _fbKey.currentState.value["terkonfirmasi"],
                              _fbKey.currentState.value["kematian"],
                              _fbKey.currentState.value["sembuh"],
                              _fbKey.currentState.value["kasus_baru"],
                              _fbKey.currentState.value["date"],
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
