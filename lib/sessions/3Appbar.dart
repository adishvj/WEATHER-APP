import 'package:flutter/material.dart';
import 'package:weatherapp/screens/bottomnavigation.dart';

class appbar extends StatelessWidget {
  const appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Color(0xFF3352C5E),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          Text(
            "Weather",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          SizedBox(
            width: 150,
          ),
          Container(
              width: 40,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz_outlined),
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
