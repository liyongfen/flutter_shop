import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'home/hot_goods.dart';
import 'home/swiper_diy.dart';
import 'home/top_navigator.dart';
import 'home/ad_banner.dart';
import 'home/leader_phone.dart';
import 'home/recommend.dart';
import 'home/floor_title.dart';
import 'home/floor_content.dart';
import '../service/service_method.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  int hotGoodsPage = 0;
  List<Map> hotGoodsList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { 
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'),centerTitle: true),
      body: FutureBuilder(
        future: request('home'),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print('首页${snapshot.hasData}');
          if(snapshot.hasData){
            Map homeData = snapshot.data;
            List<Map> swiperList = (homeData['swiperList'] as List).cast(); // 顶部轮播组件数
            List<Map> topNavigatorList = (homeData['topNavigatorList'] as List).cast(); // 顶部轮播组件数
            String adBannerImage = homeData['adBannerImage'];
            Map leaderPhone = homeData['leaderPhone'];
            List<Map> recommendList = (homeData['recommendList'] as List).cast();
            List<Map> floorList = (homeData['floorList'] as List).cast();
            String hotGoodsTitle = homeData['hotGoodsTitle'];
            //List<Map> hotGoodsList = (homeData['hotGoodsList'] as List).cast();
          
            return Container(
              color: Colors.grey.shade200,
              child: EasyRefresh(
                onLoad: ()async{
                  print('开始加载数据....');
                  FormData formData = new FormData.fromMap({'page': hotGoodsPage});
                  request('hotGoods', formData: formData).then((data){
                    List<Map> newGoodsList = (data as List ).cast();
                    print(newGoodsList);
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      hotGoodsPage++;
                    });
                  });
                },
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperList: swiperList),
                    TopNavigator(topNavigatorList: topNavigatorList.take(10).toList()),
                    AdBanner(adBannerImage: adBannerImage),
                    LeaderPhone(leaderImage: leaderPhone['image'], leaderPhone: leaderPhone['phone']),
                    Recommend(recommendList: recommendList),
                    FloorTitle(titleImage: floorList[0]['title']),
                    FloorContent(content: (floorList[0]['content']as List).cast()),
                    FloorTitle(titleImage: floorList[1]['title']),
                    FloorContent(content: (floorList[1]['content']as List).cast()),
                    HotGoods(title: hotGoodsTitle, list: hotGoodsList)
                  ],
                )
              )
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        }
      )
    );
  }
}

