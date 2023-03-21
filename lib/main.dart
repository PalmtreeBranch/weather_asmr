import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_asmr/services.dart';
import 'package:weather_asmr/weatherAPI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

PageController pageController = PageController();

var cities = [
  WeatherApp(city: "Stockholm", color: Colors.greenAccent),
  WeatherApp(city: "New York", color: Colors.pinkAccent),
  WeatherApp(city: "Tokyo", color: Colors.amberAccent)
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: cities,
      ),
    );
  }
}

class WeatherApp extends StatefulWidget {
  WeatherApp({required this.city, required this.color});

  String city;
  Color color;

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 133, 61, 210),
                widget.color,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.mirror),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
          child: FutureBuilder(
              future: fetchWeather(cityName: widget.city),
              builder: (BuildContext context, AsyncSnapshot<Weather> weather) {
                if (weather.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formatDateTimetoDate(weather.data!.date),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        formatDateTimetoTime(
                            weather.data!.date!.timeZoneOffset),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Icon(iconPicker(weather.data!.weatherMain),
                          color: Colors.white, size: 220),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "${weather.data!.temperature!.celsius!.toInt().round()}°C",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        weather.data!.areaName.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
