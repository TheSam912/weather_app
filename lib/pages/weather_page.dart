import 'package:flutter/material.dart';
import 'package:flutter_wethear/model/weather_model.dart';
import 'package:flutter_wethear/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService =
      WeatherService(apiKey: '4d82587de97cfa0034127ded4271e7d9');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String weatherImage(String mainCondition) {
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return "01d@2x.png";
      case 'clouds':
        return "04d@2x.png";
      case 'rain':
        return "10d@2x.png";
      case 'thunderstorm':
        return "11d@2x.png";
      case 'snow':
        return "13d@2x.png";
      case 'mist':
        return "50d@2x.png";
      default:
        return '0';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://openweathermap.org/img/wn/${weatherImage(_weather?.mainCondition.toString() ?? "")}"),
                      fit: BoxFit.cover)),
            ),
            Text(_weather?.cityName ?? "Loading cityName"),
            Text("${_weather?.temp.round().toString()}°C"),
            Text(_weather?.mainCondition.toString() ?? "Loading main condition")
          ],
        ),
      ),
    );
  }
}
