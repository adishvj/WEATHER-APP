import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Constants/storing_lati_longi.dart';
import 'package:weatherapp/screens/screen1.dart';
import 'package:weatherapp/screens/screen3.dart';

import '../sessions/Weathercard section.dart'; // Import your additional screen

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<dynamic> FetchData() async {
    print("hxdhuasjhxhashxahchahcnhaschjkasuchajskncjkhasucj");
    print(Positions[0]);
    if (Positions[0] == null && Positions[1] == null) {
      throw Exception('error');
    } else {
      var data = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${Positions[0]}&lon=${Positions[1]}&appid=b7c1b004d8907dee9db0248ee6acebf3"));
      var decode = jsonDecode(data.body); //it means position have value
      print(decode);
      return decode;
    }
  }

  int selectedindex = 0;
  List<Widget> pages = [
    Homepage1(),
    Placeholder(), // Placeholder for the add button
    Page3(), // Your second actual page
  ];

  void onItemTapped(int currentIndex) {
    if (currentIndex == 1) {
      // Show bottom sheet when the "Add" button is pressed
      _showBottomSheet(context);
    } else {
      // Update selected index for other buttons
      setState(() {
        selectedindex = currentIndex;
      });
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent, // Make the bottom sheet background transparent
      builder: (BuildContext context) {
        return counter.value == null
            ? CircularProgressIndicator()
            : ValueListenableBuilder<Map?>(
                valueListenable: counter,
                builder: (context, value, child) => ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height *
                          0.75, // Set height to 75% of the screen height
                      color: Colors.white.withOpacity(
                          0.3), // Adjust the opacity for transparency
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "WEATHER DATA",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(.5),
                            thickness: 1,
                          ),
                          Weathersection(
                            TempMax: value?["main"]["temp_max"] - 273,
                            TempMin: value?["main"]["temp_min"] - 273,
                            Humidity: double.tryParse(
                                    value!["main"]["humidity"].toString()) ??
                                12.0,
                            Cloudy:
                                double.parse(value["clouds"]["all"].toString()),
                            wind: value["wind"]["speed"],
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3352C5E),
      body: pages[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1d2333),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.white),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.white),
            label: "",
          ),
        ],
        onTap: onItemTapped,
        currentIndex: selectedindex,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
