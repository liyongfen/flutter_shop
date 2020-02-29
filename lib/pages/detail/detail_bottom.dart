import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/detail_goods.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_goods.dart';
import '../../provide/cart.dart';
import '../../provide/current_index.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int allGoodsCount = Provider.of<CartProvider>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
               InkWell(
                onTap: (){
                  Provider.of<CurrentIndexProvider>(context, listen: false).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(180),
                  color: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.pink
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
                child: Container(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.redAccent
                  ),
                  child: Text(
                    '$allGoodsCount', 
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(22))),
                )
              )
            ],
          ),
          InkWell(
            onTap: ()async{
              GoodsInfo goodsInfo = Provider.of<DetailGoodsProvide>(context, listen: false).detailGoods.goodsInfo;
              await Provider.of<CartProvider>(context, listen: false).save(
                goodsInfo.goodsId, 
                goodsInfo.goodsName, 
                1, 
                goodsInfo.presentPrice, 
                goodsInfo.image1
              );
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(285),
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: ScreenUtil().setSp(28))
              )
            ),
          ),
          InkWell(
            onTap: ()async{
              await Provider.of<CartProvider>(context, listen: false).remove();
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(285),
              color: Colors.redAccent,
              alignment: Alignment.center,
              child: Text(
                '立即购买',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28))
              )
            ),
          ),
        ],
      ),
    );
  }
}