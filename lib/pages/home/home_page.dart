import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/pages/details/details_page.dart';
import 'package:weather/pages/home/home_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/utils/components/description_component.dart';
import 'package:weather/utils/components/title_subtitle_component.dart';
import 'package:weather/utils/formatters/temperature_format.dart';
import 'package:weather/utils/library/global_library.dart' as globals;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _searchingCity = false;
  HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.getMyCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 414.0, height: 896.0);
    ScreenUtil().setWidth(414.0);
    ScreenUtil().setHeight(896.0);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          !_searchingCity
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchingCity = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _homeBloc.clearList();
                    setState(() {
                      _searchingCity = false;
                    });
                  },
                ),

          // action button
        ],
        title: _searchingCity
            ? TextField(
                cursorColor: Colors.white,
                showCursor: true,
                autofocus: true,
                onChanged: (address) {
                  _homeBloc.getCity(address);
                },
              )
            : Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: GoogleFonts.roboto(),
                ),
              ),
      ),
      body: _searchingCity
          ? StreamBuilder(
              stream: _homeBloc.cityOutput,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return searchedCityComponent(snapshot.data);
                } else {
                  return Container();
                }
              })
          : buildListCities(),
      floatingActionButton: !_searchingCity
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (globals.temperature != 'celsius') {
                    globals.temperature = 'celsius';
                  } else {
                    globals.temperature = 'fahrenheit';
                  }
                });
              },
              child: Text(globals.temperature == 'celsius' ? 'Cº' : 'ºF',
                  style: TextStyle(fontSize: 20)),
            )
          : Container(),
    );
  }

  buildListCities() {
    return RefreshIndicator(
      displacement: 10,
      onRefresh: _handleRefresh,
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('cities').listenable(),
          builder: (context, box, widget) {
            if (box.length > 0) {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (_, index) {
                  return myCityComponent(box.getAt(index));
                },
              );
            } else {
              return noCityComponent();
            }
          },
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(new Duration(seconds: 1));
    await _homeBloc.getMyCities();
    return null;
  }

  myCityComponent(city) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    city: city,
                  )),
        );
      },
      child: Stack(
        children: <Widget>[
          Card(
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
                        title: city.name,
                        subtitle: city.country,
                      ),
                      Text(
                        '${TemperatureFormat.verifyTemperature(city.temp)}º',
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DescriptionComponent(
                        description: city.description,
                        maxTemp: city.maxTemp,
                        minTemp: city.minTemp,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (city.favorite) {
                            city.favorite = false;
                            city.save();
                          } else {
                            city.favorite = true;
                            city.save();
                          }
                        },
                        child: city.favorite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 30,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: 1,
              top: 1,
              child: GestureDetector(
                onTap: () {
                  city.delete();
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 30,
                ),
              )),
        ],
      ),
    );
  }

  noCityComponent() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setSp(60), horizontal: ScreenUtil().setSp(45)),
      child: Column(
        children: <Widget>[
          Text(
            'Parece que você ainda não adicionou uma cidade',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(20),
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setSp(20),
          ),
          Text('Tente adicionar uma cidade usando o botão de busca',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                ),
              )),
        ],
      ),
    );
  }

  searchedCityComponent(city) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(ScreenUtil().setSp(16)),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(16)),
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setSp(150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleSubtitleComponent(
              title: city.name,
              subtitle: city.sys.country,
            ),
            Spacer(),
            Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      if (_homeBloc.setCity(city)) {
                        setState(() {
                          _searchingCity = false;
                          _homeBloc.clearList();
                        });
                      } else {
                        BotToast.showText(
                            text: 'Cidade já adicionada',
                            contentColor: Colors.grey[700],
                            duration: Duration(milliseconds: 3500));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setSp(8)),
                      child: Text(
                        'ADICIONAR',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                          color: Color(0xff0078be),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(14),
                        )),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
