import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          _allCheckbox(context),
          _allPriceArea(context),
          _goButton(context),
        ],
      ),
    );
  }

  Widget _allCheckbox(context){
    bool allIsCheck = Provider.of<CartProvider>(context).allIsCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: allIsCheck,
            activeColor: Colors.redAccent,
            onChanged: (bool val){
              Provider.of<CartProvider>(context, listen: false).changeAllCheck(val);
            }
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget _allPriceArea(context){
    return Container(
      child: Column(
        children: <Widget>[
          _totalPrice(context),
          Container(
            width: ScreenUtil().setWidth(380),
            alignment: Alignment.centerRight,
            child: Text(
              '满99元免配送费,预购免配送费', 
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
            ),
          )
        ],
      ),
    );
  }

  Widget _totalPrice(context){
    double allGoodsPrice = Provider.of<CartProvider>(context).allGoodsPrice;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(250),
            child: Text(
              '合计：',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30)
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(130),
            child: Text(
              '￥${allGoodsPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Colors.redAccent
              ),
            ),
          )
        ],
      ),
    );
  }
    
  Widget _goButton(context){
    int allGoodsCount = Provider.of<CartProvider>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(3.0)
      ),
      child: InkWell(
        onTap: (){},
        child: Text(
          '结算($allGoodsCount)',
          style: TextStyle(color: Colors.white),
          ),
      )
    );
  }
    
}
    
