import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:grilshop_app/config/index.dart';
import 'package:grilshop_app/pages/cart_page.dart';
import 'package:grilshop_app/pages/category_page.dart';
import 'package:grilshop_app/pages/home_page.dart';
import 'package:grilshop_app/pages/member_page.dart';
import 'package:grilshop_app/provider/current_index_provider.dart';

import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key key}) : super(key: key);
  final List<BottomNavigationBarItem> _bottomTabs = [
    BottomNavigationBarItem(
      title: Text(KString.homeTitle), //首页
      icon: Icon(
        Icons.home,
      ),
    ),
    BottomNavigationBarItem(
      title: Text(KString.categoryTitle), //分类
      icon: Icon(
        Icons.category,
      ),
    ),
    BottomNavigationBarItem(
      title: Text(KString.shoppingCartTitle), //购物车
      icon: Icon(
        Icons.shopping_cart,
      ),
    ),
    BottomNavigationBarItem(
      title: Text(KString.memberTitle), //会员中心
      icon: Icon(
        Icons.person,
      ),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  //内容页
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 734),
      allowFontScaling: true,
      builder: () {
        return Consumer<CurrentIndexProvider>(
          builder: (context, model, child) {
            int currentIndex =
                Provider.of<CurrentIndexProvider>(context, listen: false)
                    .currentIndex;
            return Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: _bottomTabs,
                  currentIndex: currentIndex,
                  onTap: (index) {
                    Provider.of<CurrentIndexProvider>(context, listen: false)
                        .changeIndex(index);
                  },
                ),
                body: IndexedStack(
                  index: currentIndex,
                  children: tabBodies,
                ));
          },
        );
      },
    );
  }
}
