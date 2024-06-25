import 'package:flutter/cupertino.dart';

import '../Widgets/WeatherData.dart';

class Weathersection extends StatefulWidget {
  final double TempMax;
  final double TempMin;
  final double Humidity;
  final double Cloudy;
  final double wind;
  const Weathersection(
      {super.key,
      required this.TempMax,
      required this.TempMin,
      required this.Humidity,
      required this.Cloudy,
      required this.wind});

  @override
  State<Weathersection> createState() => _WeathersectionState();
}

class _WeathersectionState extends State<Weathersection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          WeatherData(
            WeatherStatuses: "Temprature Max",
            Weatherdata: widget.TempMax,
            WeatherIcon: CupertinoIcons.thermometer,
          ),
          SizedBox(
            height: 20,
          ),
          WeatherData(
              WeatherStatuses: "Temprature Min",
              Weatherdata: widget.TempMin,
              WeatherIcon: CupertinoIcons.thermometer),
          SizedBox(
            height: 20,
          ),
          WeatherData(
              WeatherStatuses: "Humidity            ",
              Weatherdata: widget.Humidity,
              WeatherIcon: CupertinoIcons.drop),
          SizedBox(
            height: 20,
          ),
          WeatherData(
              WeatherStatuses: "Cloudy                ",
              Weatherdata: widget.Cloudy,
              WeatherIcon: CupertinoIcons.cloud),
          SizedBox(
            height: 20,
          ),
          WeatherData(
            WeatherStatuses: "Wind",
            Weatherdata: widget.wind,
            WeatherIcon: CupertinoIcons.thermometer,
          ),
        ],
      ),
    );
  }
}
