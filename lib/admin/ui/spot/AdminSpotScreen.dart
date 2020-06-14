import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/admin/ui/spot/AdminAddSpotScreen.dart';
import 'package:mpcovid19/admin/ui/spot/AdminChangeSpotScreen.dart';
import 'package:mpcovid19/models/Spot.dart';
import 'package:status_alert/status_alert.dart';

class AdminSpotScreen extends StatefulWidget {
  @override
  _AdminSpotScreenState createState() => _AdminSpotScreenState();
}

class _AdminSpotScreenState extends State<AdminSpotScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) {
                return new AdminAddSpotScreen();
              },
            ),
          );
        },
        backgroundColor: kPrimaryColor,
        child: new Icon(
          Icons.add,
        ),
      ),
      backgroundColor: KBackgroundColorSecondary,
      appBar: new AppBar(
        title: new Text("Admin Posko"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: AdminSpotsListView(),
    );
  }
}

class AdminSpotsListView extends StatelessWidget {

  _deleteDataSpotById(id) async {
    print("Tombol Delete Berhasil di Tekan");
    String url =
        'https://mp-covid19-api.000webhostapp.com/public/api/spot/$id/delete';
    print(url);
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await http.post(url, headers: headers);
    var statusCode = response.body;
    print(statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Spot>>(
      future: _fetchSpots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Spot> data = snapshot.data;
          return _hospitalsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return new Container(
          child: new Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<List<Spot>> _fetchSpots() async {
    final hospitalsListAPIUrl =
        "https://mp-covid19-api.000webhostapp.com/public/api/spots";
    final response = await http.get(hospitalsListAPIUrl);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((spot) => new Spot.fromJson(spot))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _hospitalsListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _container(
          data[index].idSpot,
          data[index].name,
          data[index].address,
          data[index].city,
          data[index].longitude,
          data[index].latitude,
          context,
        );
      },
    );
  }

  Container _container(id, name, address, city, longitude, latitude, context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: new InkWell(
        onTap: (){
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) {
                return new AdminChangeSpotScreen(
                  id: id,
                  name: name,
                  address: address,
                  city: city,
                  longitude: longitude,
                  latitude: latitude,
                );
              },
            ),
          );
        },
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Hapus Data!"),
                content:
                Text("Apakah Kamu Benar - Benar Mau Menghapus Data Ini?"),
                actions: [
                  FlatButton(
                    child: Text(
                      "Submit",
                      style: new TextStyle(color: kPrimaryColor),
                    ),
                    onPressed: () {
                      _deleteDataSpotById(id);
                      Navigator.of(context).pop();
                      StatusAlert.show(
                        context,
                        duration: Duration(seconds: 2),
                        title: 'Data Berhasil di Hapus',
                        configuration: IconConfiguration(
                          icon: Icons.done,
                        ),
                      );
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Keluar",
                      style: new TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                elevation: 5,
              );
            },
          );
        },
        child: ListTile(
          leading: new Icon(
            Icons.local_hospital,
            color: kPrimaryColor,
          ),
          title: new Text(name),
          subtitle: new Text(address),
        ),
      ),
    );
  }
}
