import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/database/city_model.dart';
import 'package:weather/models/weather_response_model.dart';
import 'package:weather/services/open_weather_api.dart';

class HomeBloc extends BlocBase {
  OpenWeather _openWeather = OpenWeather();

  final BehaviorSubject<CityResponse> _cityController =
      BehaviorSubject<CityResponse>();

  Observable<CityResponse> get cityOutput => _cityController.stream;

  Sink<CityResponse> get _cityInput => _cityController.sink;

  getCity(city) async {
    Response _response = await _openWeather.getCity(city);
    if (_response != null) {
      CityResponse _cityResponse = CityResponse.fromJson(_response.data);

      _cityInput.add(_cityResponse);
    }
  }

  setCity(CityResponse city) {
    var box = Hive.box('cities');

    bool haveCity =
        box.values.where((x) => x.id == city.id).toList().length > 0;
    if (haveCity) {
      return false;
    } else {
      var newCity = City()
        ..id = city.id
        ..name = city.name
        ..description = city.weather.first.description
        ..icon = city.weather.first.icon
        ..temp = city.main.temp
        ..minTemp = city.main.minTemp
        ..maxTemp = city.main.maxTemp
        ..country = city.sys.country
        ..favorite = false;

      box.add(newCity);
      return true;
    }
  }

  getMyCities() async {
    var box = await Hive.openBox('cities');
    box.length;

    _cityInput.add(null);
  }

  clearList() async {
    _cityInput.add(null);
  }

  @override
  void dispose() {
    _cityController.close();
//    Hive.close();
    super.dispose();
  }
}
