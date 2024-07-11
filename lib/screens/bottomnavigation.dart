import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Constants/storing_lati_longi.dart';
import 'package:weatherapp/screens/screen1.dart';

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
    // Your second actual page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3352C5E),
      body: pages[selectedindex],
    );
  }
}
