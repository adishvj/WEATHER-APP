import 'package:flutter/material.dart';

class WeatherData extends StatelessWidget {
  String WeatherStatuses;
  double Weatherdata;
  IconData WeatherIcon;

  WeatherData({
    super.key,
    required this.WeatherStatuses,
    required this.Weatherdata,
    required this.WeatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(WeatherStatuses,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        Spacer(),
        Text(
          Weatherdata.toStringAsFixed(0),
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          WeatherIcon,
          color: Colors.white.withOpacity(.7),
        ),
      ],
    );
  }
}
