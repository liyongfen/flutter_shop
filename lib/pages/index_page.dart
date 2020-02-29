import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provide/current_index.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';

class IndexPage extends StatelessWidget {
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // print('设备像素密度：${ScreenUtil.pixelRatio}');
    // print('设备宽度：${ScreenUtil.screenWidth}');
    // print('设备高度：${ScreenUtil.screenHeight}');
     ScreenUtil.init(context, width: 750, height: 1334);//初始化屏幕数据
    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;
    return Scaffold(
      backgroundColor: Colors.pink,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,//
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          Provider.of<CurrentIndexProvider>(context, listen: false).changeIndex(index);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}