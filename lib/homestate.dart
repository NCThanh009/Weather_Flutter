import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeState extends State<MyApp> {
  var temp;
  var desc;
  var curr;
  var hum;
  var wind;
  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=16&lon=108&units=imperial&appid=7dfe2d591ff5d64ff7e4a4546f942d81"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.desc = results['weather'][0]['description'];
      this.curr = results['weather'][0]['main'];
      this.hum = results['main']['humidity'];
      this.wind = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Việt Nam',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                temp != null ? temp.toString() + '\u00B0' : "Loading",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  curr != null ? curr.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: ListView(
              children: [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text('Nhiệt độ'),
                  trailing: Text(
                    temp != null ? temp.toString() + '\u00B0' : "Loading",
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text('Thời tiết'),
                  trailing: Text(desc != null ? desc.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text('Độ ẩm'),
                  trailing: Text(hum != null ? hum.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text('Tốc độ gió'),
                  trailing: Text(wind != null ? wind.toString() : "Loading"),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
