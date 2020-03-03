import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/utils/formatters/temperature_format.dart';

class DescriptionComponent extends StatefulWidget {
  final description;
  final minTemp;
  final maxTemp;

  const DescriptionComponent(
      {Key key, this.description, this.minTemp, this.maxTemp})
      : super(key: key);

  @override
  _DescriptionComponentState createState() => _DescriptionComponentState();
}

class _DescriptionComponentState extends State<DescriptionComponent> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: '${widget.description}\n',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
            color: Color(0xfff28200),
            fontSize: ScreenUtil().setSp(14),
          ))),
      TextSpan(
          text:
              '${TemperatureFormat.verifyTemperature(widget.minTemp)}º '
                  '- ${TemperatureFormat.verifyTemperature(widget.maxTemp)}º',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
            color: Color(0xff000000),
            fontSize: ScreenUtil().setSp(12),
          )))
    ]));
  }
}
