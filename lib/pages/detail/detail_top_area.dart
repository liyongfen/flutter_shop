import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail_goods.dart';
import '../../model/detail_goods.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailGoodsModel goods = Provider.of<DetailGoodsProvide>(context).detailGoods;
    
    if(goods != null){
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _goodsImage(goods.goodsInfo.image1),
            _goodsName(goods.goodsInfo.goodsName),
            _goodsNum(goods.goodsInfo.goodsSerialNumber),
            _goodsPrice(goods.goodsInfo.presentPrice, goods.goodsInfo.oriPrice),
          ]
        ),
      );
    } else {
      return Text('正在加载中...');
    }
  }

  Widget _goodsImage(String url){
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(String name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: Text(
        name, 
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }

  Widget _goodsNum(String number){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10), 
        top: ScreenUtil().setWidth(10), 
        bottom: ScreenUtil().setWidth(10)
      ),
      child: Text(
        '编号：${number}',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(26),
          color: Colors.black26
        ),
      ),
    );
  }

  Widget _goodsPrice(double presentPrice, double oriPrice){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: Row(
        children: <Widget>[
          Container(
            child: _nowPrice(presentPrice),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: Text('市场价格：'),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: _oldPrice(oriPrice),
          )
        ],
      ),
    );
  }

  Text _nowPrice(double presentPrice){
    return Text(
      '￥${presentPrice}',
      style: TextStyle(
        color: Colors.redAccent,
      ),
    );
  }
  
  Text _oldPrice(double oriPrice){
    return Text(
      '￥${oriPrice}',
      style: TextStyle(
        color: Colors.black26,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }

}