import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'title_subtitle_component.dart';

class CardComponent extends StatefulWidget {
  final title;
  final subtitle;
  final temp;
  final tempMin;
  final tempMax;
  final description;
  final favorite;

  const CardComponent(
      {Key key,
      this.title,
      this.subtitle,
      this.temp,
      this.tempMin,
      this.tempMax, this.description, this.favorite})
      : super(key: key);

  @override
  _CardComponentState createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
