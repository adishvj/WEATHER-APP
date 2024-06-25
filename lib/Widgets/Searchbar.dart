import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  Searchbar({super.key, required this.city, required this.onpress});
  final TextEditingController city;
  void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: city,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.purple,
          decoration: InputDecoration(
              hintText: 'Search for a city',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              prefixIcon: IconButton(
                onPressed: onpress,
                icon: Icon(Icons.search, color: Colors.white),
              )),
        ),
      ),
    );
  }
}
//
