import 'package:flutter/material.dart';
import 'homestate.dart';

void main() {
  debugShowCheckedModeBanner:
  false;
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  HomeState createState() => HomeState();
}
