import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Constants/storing_lati_longi.dart';
import 'package:weatherapp/screens/alarmScreen.dart';

class Homepage1 extends StatefulWidget {
  String? city;
  Homepage1({super.key, this.city});

  @override
  State<Homepage1> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage1> {
  Position? position;
  Future<void> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    setState(() {});
  }

  Future<dynamic> FetchData() async {
    print(position);
    if (position == null) {
      throw Exception('error');
    } else {
      var data = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${position!.latitude}&lon=${position!.longitude}&appid=b7c1b004d8907dee9db0248ee6acebf3"));
      var decode = jsonDecode(data.body); //it means position have value

      PostPosition(lati: position!.latitude, longi: position!.longitude);

      return decode;
    }
  }

  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return position == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : FutureBuilder(
            future: FetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                counter.value = snapshot.data!;
                return ListView(scrollDirection: Axis.horizontal, children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/background (2).png",
                          ),
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                        Positioned(
                            top: 120,
                            left: 100,
                            child: Text(
                              snapshot.data!["name"].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 45),
                            )),
                        Positioned(
                            top: 175,
                            left: 140,
                            child: Row(
                              children: [
                                Text(
                                  '${((snapshot.data!['main']['temp']) - 273).toStringAsFixed(0)}°',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 90,
                                  ),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                )
                              ],
                            )),
                        Positioned(
                            top: 270,
                            left: 141,
                            child: Text(
                              snapshot.data!["weather"][0]["description"],
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontSize: 22,
                              ),
                            )),
                        Positioned(
                            top: 300,
                            left: 128,
                            child: Text(
                              "H:${snapshot.data['main']['humidity']}\tWS:${snapshot.data['wind']['speed']}"
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontSize: 22,
                              ),
                            )),
                        Positioned(
                            top: 350,
                            left: 60,
                            child: Image(
                              image: AssetImage("assets/images/House (2).png"),
                              height: 350,
                              width: 250,
                            )),
                        Positioned(child: AlarmScreen())
                      ],
                    ),
                  ),
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error.toString()}');
              }
              return Center(child: CircularProgressIndicator());
            },
          );
  }
}
