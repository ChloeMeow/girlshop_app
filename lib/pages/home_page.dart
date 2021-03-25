import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:grilshop_app/config/index.dart';
import 'package:grilshop_app/config/string.dart';
import 'package:grilshop_app/service/http_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//AutomaticKeepAliveClientMixin自动保持客户混合，使得当前页面不会被刷新
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //火爆专区分页
  int page = 1;
  //火爆专区数据
  List<Map> hotGoodsList = [];
  //防止刷新处理 保持当前状态
  @override
  bool get wantKeepAlive => true;

  //GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterFoot>();
  //diff
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
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast(); //分类
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast(); //商品推荐
              List<Map> floor1 =
                  (data['data']['floor1'] as List).cast(); //底部商品推荐
              Map fp1 = data['data']['floorPic']; //广告
              return EasyRefresh(
                footer: ClassicalFooter(
                  //key: _footerKey,
                  bgColor: Colors.white,
                  textColor: KColor.refreshTextColor,
                  infoColor: KColor.refreshTextColor,
                  showInfo: true,
                  noMoreText: '',
                  infoText: KString.loading,
                  loadReadyText: KString.loadReadyText,
                ),
                child: ListView(
                  children: [
                    SwiperDiy(
                      swiperDataList: swiperDataList,
                    ),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    RecommendUI(
                      recommendList: recommendList,
                    ),
                    FloorPic(
                      floorPic: fp1,
                    ),
                    Floor(
                      floor: floor1,
                    ),
                    _hotGoods(),
                  ],
                ),
                onLoad: () async {
                  print('开始加载更多');
                  _getHotGoods();
                },
              );
            } else {
              return Center(child: Text("加载中"));
            }
          }),
    );
  }

  void _getHotGoods() {
    var formPage = {'page': page};
    request('getHotGoods', formData: formPage).then((value) {
      var data = json.decode(value.toString());
      // print(data);
      List<Map> newGoodsList = (data['data'] as List).cast(); //
      //设置火爆专区数据列表
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }
  

  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(width: 0.5, color: KColor.homeSubTitleTextColor))),
    child: Text(
      KString.hotGoodsTitle,
      style: TextStyle(color: KColor.homeSubTitleTextColor),
    ),
  );
  //火爆专区子项
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((value) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  value['image'],
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(200),
                  fit: BoxFit.cover,
                ),
                Text(
                  value['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(children: <Widget>[
                  Text(
                    '￥${value['presentPrice']}',
                    style: TextStyle(color: KColor.presentPriceTextColor),
                  ),
                  Text(
                    '￥${value['oriPrice']}}',
                    style: TextStyle(color: KColor.oriPriceTextColor),
                  ),
                ])
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text("");
    }
  }

  //火爆专区组合
  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

//首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(730),
      height: ScreenUtil().setHeight(250),
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Image.network(
                '${swiperDataList[index]['image']}',
                fit: BoxFit.cover,
              ),
            );
          },
          //滑动分页
          pagination: SwiperPagination(),
          //自动播放：是的
          autoplay: true,
          itemCount: swiperDataList.length),
    );
  }
}

//首页分类导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        //跳转到分类页面
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(40),
          ),
          Text(item['firstCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }
}

// class TopNavigator extends StatelessWidget {
//   final List navigatorList;
//   const TopNavigator({Key key, this.navigatorList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: ScreenUtil().setHeight(320),
//       child: GridView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: 10,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 5,
//             // crossAxisSpacing: 1,
//             // mainAxisSpacing: 1,
//             childAspectRatio: 1,
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(
//                 child: _gridViewItem(
//                   url: navigatorList[index]['image'],
//                   name: navigatorList[index]['firstCategoryName'],
//                 ),
//                 onTap: () {});
//           }),
//     );
//   }

//   Widget _gridViewItem({
//     String url,
//     String name,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.network(
//           url,
//           width: ScreenUtil().setWidth(40),
//           height: ScreenUtil().setWidth(40),
//         ),
//         Text(name),
//       ],
//     );
//   }
// }

//商品推荐
class RecommendUI extends StatelessWidget {
  final List recommendList;
  RecommendUI({Key key, this.recommendList}) : super(key: key);

  //推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 0.5,
            color: KColor.defaultBorderColor,
          ))),
      child: Text(
        KString.recommendText,
        style: TextStyle(color: KColor.homeSubTitleTextColor),
      ),
    );
  }

  //商品推荐列表
  Widget _recommendList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (BuildContext context, int index) {
            return _item(context, index);
          }),
    );
  }

  Widget _item(context, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(200),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: KColor.defaultBorderColor),
            )),
        child: Column(children: <Widget>[
          //防止溢出
          Expanded(
            child: Image.network(
              recommendList[index]['image'],
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            '￥${recommendList[index]["presentPrice"]}',
            style: TextStyle(color: KColor.presentPriceTextColor),
          ),
          Text(
            '￥${recommendList[index]['oriPrice']}}',
            style: KFont.oriPriceStyle,
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList(context)],
      ),
    );
  }
}

//商品推荐中间广告
class FloorPic extends StatelessWidget {
  final Map floorPic;
  const FloorPic({Key key, this.floorPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
          child: Image.network(
            floorPic['PICTURE_ADDRESS'],
            fit: BoxFit.cover,
          ),
          onTap: () {}),
    );
  }
}

class Floor extends StatelessWidget {
  List<Map> floor;
  Floor({Key key, this.floor}) : super(key: key);

  //跳转到商品详情
  void jumpDetail(context, String goodsId) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            //左侧商品
            child: Column(
              children: [
                //左上角大图
                Container(
                  padding: EdgeInsets.only(top: 4),
                  height: ScreenUtil().setHeight(300),
                  child: InkWell(
                      child:
                          Image.network(floor[0]['image'], fit: BoxFit.cover),
                      onTap: () {
                        jumpDetail(context, floor[0]['goodsId']);
                      }),
                ),
                //左下角小图
                Container(
                  padding: EdgeInsets.only(top: 1, right: 1),
                  height: ScreenUtil().setHeight(150),
                  child: InkWell(
                      child:
                          Image.network(floor[1]['image'], fit: BoxFit.cover),
                      onTap: () {
                        jumpDetail(context, floor[1]['goodsId']);
                      }),
                )
              ],
            ),
          ),
          Expanded(
            //右侧商品
            child: Column(
              children: [
                //右上图
                Container(
                  padding: EdgeInsets.only(top: 4, left: 1, bottom: 1),
                  height: ScreenUtil().setHeight(150),
                  child: InkWell(
                      child:
                          Image.network(floor[2]['image'], fit: BoxFit.cover),
                      onTap: () {
                        jumpDetail(context, floor[2]['goodsId']);
                      }),
                ),
                //右中图
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(150),
                  child: InkWell(
                      child:
                          Image.network(floor[3]['image'], fit: BoxFit.cover),
                      onTap: () {
                        jumpDetail(context, floor[3]['goodsId']);
                      }),
                ),
                //右下图
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(150),
                  child: InkWell(
                      child:
                          Image.network(floor[4]['image'], fit: BoxFit.cover),
                      onTap: () {
                        jumpDetail(context, floor[4]['goodsId']);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
