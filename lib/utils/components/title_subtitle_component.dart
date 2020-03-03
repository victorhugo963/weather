import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSubtitleComponent extends StatefulWidget {
  final title;
  final subtitle;

  const TitleSubtitleComponent({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  _TitleSubtitleComponentState createState() => _TitleSubtitleComponentState();
}

class _TitleSubtitleComponentState extends State<TitleSubtitleComponent> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: '${widget.title}\n',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: ScreenUtil().setSp(24),
              ))),
      TextSpan(
          text: widget.subtitle,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: ScreenUtil().setSp(14),
              )))
    ]));;
  }
}
