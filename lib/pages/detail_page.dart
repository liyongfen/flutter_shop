import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/detail_goods.dart';
import 'detail/detail_explain.dart';
import 'detail/detail_top_area.dart';
import 'detail/detail_tabbar.dart';
import 'detail/detail_web.dart';
import 'detail/detail_bottom.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;
  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情页'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ),
      body: FutureBuilder(
        future: _getDetailGoodsInfo(context, goodsId),
        builder: (context, snapshot){
          print('详情页数据：${snapshot.hasData}');
          if(snapshot.hasData){
            return Container(
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      DetailTopArea(),
                      DetailExplain(),
                      DetailTabbar(),
                      DetailWeb(),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailBottom()
                  )
                ],
              )
            );
          } else {
            return Text('加载中...');
          }
        }
      )
    );
  }

  Future _getDetailGoodsInfo(context, id) async{
    await Provider.of<DetailGoodsProvide>(context, listen: false).getDetailGoodsInfo(id);
    return '加载完成';
  }
}