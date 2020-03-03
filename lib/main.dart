import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/database/city_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'pages/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _openBox().then((v) {
    runApp(MyApp());
  });
}

Future _openBox() async {
  final applicationDocumentDiretory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(applicationDocumentDiretory.path);
  Hive.registerAdapter(CityAdapter());
  await Hive.openBox(
    'cities',
    compactionStrategy: (int total, int deleted) {
      return deleted > 20;
    },
  );
  return;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('pt', 'BR')
        ],
        locale: Locale('pt', 'BR'),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Cidades'),
      ),
    );
  }
}
