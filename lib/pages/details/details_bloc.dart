import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/database/city_model.dart';
import 'package:weather/models/forecast_response_model.dart';
import 'package:weather/services/open_weather_api.dart';
import "package:collection/collection.dart";

class DetailsBloc extends BlocBase {
  OpenWeather _openWeather = OpenWeather();

  final BehaviorSubject<List<Detail>> _detailsCityController =
      BehaviorSubject<List<Detail>>();

  Observable<List<Detail>> get detailsCityOutput =>
      _detailsCityController.stream;

  Sink<List<Detail>> get _detailsCityInput => _detailsCityController.sink;

  getDetailsCity(City city) async {
    Response _response = await _openWeather.getDetailsCity(city.id);
    if (_response != null) {
      Map<String, dynamic> groupByData =
          groupBy(_response.data['list'], (obj) => obj['dt_txt'].split(' ')[0]);

      List<Detail> list = List<Detail>();

      for (var entry in groupByData.entries) {
        var temp = 0.0;
        var tempMin = 0.0;
        var tempMax = 0.0;
        for (var value in entry.value) {
          Detail _forecastResponse = Detail.fromJson(value);
          temp = temp + _forecastResponse.main.temp;
          tempMin = tempMin + _forecastResponse.main.tempMin;
          tempMax = tempMax + _forecastResponse.main.tempMax;
        }
        Detail _forecastResponse = Detail.fromJson(entry.value.first);
        _forecastResponse.main.temp = temp / entry.value.length;
        _forecastResponse.main.tempMin = tempMin / entry.value.length;
        _forecastResponse.main.tempMax = tempMax / entry.value.length;
        list.add(_forecastResponse);
      }
      _detailsCityInput.add(list);
    }
  }

  @override
  void dispose() {
    _detailsCityController.close();
    super.dispose();
  }
}
