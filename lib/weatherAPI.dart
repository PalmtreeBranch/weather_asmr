import 'package:weather/weather.dart';

Future<Weather> fetchWeather({required String cityName}) async {
  String apiKey = "5266fb6408e770930ec04f862e3f5e7a";
  WeatherFactory wf = new WeatherFactory(apiKey);
  Weather weatherOutput = await wf.currentWeatherByCityName(cityName);
  return weatherOutput;
}
