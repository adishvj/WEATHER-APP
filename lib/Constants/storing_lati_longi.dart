import 'package:flutter/material.dart';

final ValueNotifier<Map?> counter = ValueNotifier<Map?>(null);

List Positions = [];
void PostPosition({required double lati, required double longi}) {
  Positions.add(lati);
  Positions.add(longi);
  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
  print(Positions);
}
