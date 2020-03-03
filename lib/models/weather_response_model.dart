class CityResponse {
  List<Weather> weather;
  Main main;
  Sys sys;
  int id;
  String name;
  int cod;

  CityResponse(
      { this.weather,
        this.main,
        this.sys,
        this.id,
        this.name,
        this.cod});

  CityResponse.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }

    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Weather {
  String description;
  String icon;

  Weather({this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  double temp;
  double minTemp;
  double maxTemp;

  Main(
      {this.temp,
        this.minTemp,
        this.maxTemp,});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    minTemp = json['temp_min'];
    maxTemp = json['temp_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['temp_min'] = this.minTemp;
    data['temp_max'] = this.maxTemp;
    return data;
  }
}

class Sys {
  String country;

  Sys({this.country});

  Sys.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    return data;
  }
}
