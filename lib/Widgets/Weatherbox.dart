import 'package:flutter/material.dart';

class WeatherBox extends StatefulWidget {
  String? cityname;
  double Temprature;
  int humidity;
  double windspeed;
  String description;
  WeatherBox({
    super.key,
    required this.Temprature,
    required this.humidity,
    required this.windspeed,
    required this.description,
    this.cityname,
  });

  @override
  State<WeatherBox> createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 200,
      width: 360,
      child: Stack(children: [
        Image.asset(
          "assets/images/box.jpg",
          fit: BoxFit.cover,
        ),
        Positioned(
            left: 170,
            bottom: 40,
            child: widget.description == 'few clouds'
                ? Image.asset(
                    "assets/images/few cloud.png",
                    height: 150,
                    width: 40,
                  )
                : widget.description == 'broken clouds'
                    ? Image.asset(
                        "assets/images/scatterd cloud.png",
                        height: 150,
                        width: 150,
                      )
                    : widget.description == 'overcast clouds'
                        ? Image.asset(
                            "assets/images/scatterd cloud.png",
                            height: 150,
                            width: 150,
                          )
                        : widget.description == 'heavy intensity rain'
                            ? Image.asset(
                                "assets/images/heavy_rain-removebg-preview.png",
                                height: 150,
                                width: 150,
                              )
                            : widget.description == 'mist'
                                ? Image.asset(
                                    "assets/images/mist-removebg-preview.png",
                                    height: 150,
                                    width: 150,
                                  )
                                : Image.asset(
                                    "assets/images/Moon cloud fast wind.png")),
        Positioned(
            top: 20,
            left: 5,
            child: Text(
              '${widget.Temprature.toStringAsFixed(1)}°c',
              style: TextStyle(fontSize: 40, color: Colors.white),
            )),
        Positioned(
            top: 70,
            left: 13,
            child: Text(
              "H:${widget.humidity.toStringAsFixed(1)} WS:${widget.windspeed.toStringAsFixed(1)}",
              style: TextStyle(color: Colors.white.withOpacity(.5)),
            )),
        Positioned(
            top: 150,
            left: 13,
            child: Text(
              widget.cityname ?? 'gtytyt',
              style: TextStyle(color: Colors.white),
            )),
        Positioned(
            top: 150,
            left: 220,
            child: Text(
              widget.description,
              style: TextStyle(color: Colors.white),
            )),
      ]),
    );
  }
}
