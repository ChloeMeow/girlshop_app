import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grilshop_app/config/string.dart';
import 'package:grilshop_app/service/http_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      //防止重绘
      body: FutureBuilder(
          future: request('homePageContent', formData: null),
          //生成器
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              print(data);
              return Container(
                child: Text("111"),
              );
            } else {
              return Container(child: Text("加载中"));
            }
          }),
    );
  }
}
