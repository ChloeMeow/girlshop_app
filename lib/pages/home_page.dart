import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grilshop_app/config/string.dart';
import 'package:grilshop_app/service/http_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//AutomaticKeepAliveClientMixin自动保持客户混合，使得当前页面不会被刷新
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //防止刷新处理 保持当前状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('首页刷新了');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              // return Container(
              //   child: Text("111"),
              // );
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast(); //轮播图
              List<Map> category =
                  (data['data']['category'] as List).cast(); //分类
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast(); //商品推荐
              List<Map> floor1 =
                  (data['data']['floor1'] as List).cast(); //底部商品推荐
              List<Map> fp1 = (data['data']['fp1'] as List).cast(); //广告
            } else {
              return Container(child: Text("加载中"));
            }
          }),
    );
  }
}
