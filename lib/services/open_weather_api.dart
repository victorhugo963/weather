import 'package:dio/dio.dart';

class OpenWeather {
  final _apiKey = '5b50ca7a85adbc22f6e533796ac791cf';
  final _baseUrl = 'https://api.openweathermap.org/data/2.5';
  final _baseIconUrl = 'https://api.openweathermap.org/img/w/';
  var iconurl = "http://openweathermap.org/img/w/02n.png";

  getCity(city) async {
    try {
      Response response = await Dio()
          .get('$_baseUrl/weather', queryParameters: {"q": city, "appid": _apiKey,"lang": "pt"});
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }


  getDetailsCity(cityId) async {
    try {
      Response response = await Dio()
          .get('$_baseUrl/forecast', queryParameters: {"id": cityId, "appid": _apiKey, "lang": "pt"});
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }
}
