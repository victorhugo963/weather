import 'package:weather/utils/library/global_library.dart' as globals;

class TemperatureFormat {
  static toCelcius(temperature) {
    var celsius = temperature - 273.15;
    return celsius.toStringAsFixed(0);
  }

  static toFahrenheit(temperature) {
    var fahrenheit = (temperature - 273.15) * 9 / 5 + 32;
    return fahrenheit.toStringAsFixed(0);
  }

  static toKelvin(temperature) {
    return temperature.toStringAsFixed(0);
  }

  static verifyTemperature(temperature) {
    switch (globals.temperature) {
      case 'celsius':
        return toCelcius(temperature);
        break;
      case 'fahrenheit':
        return toFahrenheit(temperature);

        break;
      case 'kelvin':
        return toKelvin(temperature);
        break;
    }
  }
}
