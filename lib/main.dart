import 'package:flutter/material.dart';
import 'package:grilshop_app/config/index.dart';
import 'package:grilshop_app/config/string.dart';
import 'package:grilshop_app/pages/index_page.dart';
import 'package:grilshop_app/provider/current_index_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentIndexProvider = CurrentIndexProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: CurrentIndexProvider())
        ],
        child: MaterialApp(
          title: KString.mainTitle, //Flutter女装商城
          debugShowCheckedModeBanner: false,
          //主题
          theme: ThemeData(primaryColor: KColor.primaryColor),
          home: IndexPage(),
        ));
  }
}
