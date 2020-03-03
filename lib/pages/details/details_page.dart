import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/database/city_model.dart';
import 'package:weather/utils/components/description_component.dart';
import 'package:weather/utils/components/title_subtitle_component.dart';
import 'package:weather/utils/formatters/temperature_format.dart';
import 'package:intl/intl.dart';
import 'package:weather/utils/library/global_library.dart' as globals;

import 'details_bloc.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.city}) : super(key: key);

  final City city;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsBloc _detailsBloc = DetailsBloc();
  bool _isCelsius = true;

  @override
  void initState() {
    _detailsBloc.getDetailsCity(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.city.name,
            style: GoogleFonts.roboto(),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text('Previsão para os próximos dias'),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _detailsBloc.detailsCityOutput,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return dayComponent(snapshot.data[index]);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }

  dayComponent(city) {
    var date = city.dtTxt;
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(ScreenUtil().setSp(16)),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(16)),
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setSp(150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TitleSubtitleComponent(
                  title: DateFormat(
                          'EEEE', Localizations.localeOf(context).languageCode)
                      .format(DateTime.parse(date)),
                  subtitle:
                      '${DateFormat('d', Localizations.localeOf(context).languageCode).format(DateTime.parse(date))} de '
                      '${DateFormat('MMMM', Localizations.localeOf(context).languageCode).format(DateTime.parse(date))}',
                ),
                Text(
                  '${TemperatureFormat.verifyTemperature(city.main.temp)}º',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color(0xfff28200),
                      fontSize: ScreenUtil().setSp(34),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DescriptionComponent(
                  description: city.weather.first.description,
                  maxTemp: city.main.tempMax,
                  minTemp: city.main.tempMin,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
