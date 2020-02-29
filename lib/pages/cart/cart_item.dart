import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../model/cart.dart';
import './cart_count.dart';
import '../../provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.all(5),
      //color: Colors.white,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBtn(context, item),
          _cartImage(),
         _cartGoodsName(),
         _cartPrice(context),
        ],
      ),
    );
  }

  Widget _cartCheckBtn(BuildContext context, CartModel item){
    return Container(
      child: Checkbox(
        value: item.isCheck, 
        activeColor: Colors.redAccent,
        onChanged: (bool val){
          item.isCheck = val;
          Provider.of<CartProvider>(context, listen: false).changeCheckStatus(item);
        }
      ),
    );
  }

  Widget _cartImage(){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
  
  Widget _cartGoodsName(){
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(150),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  Widget _cartPrice(context){
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(150),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('￥${item.price}'),
          InkWell(
            onTap: (){
              Provider.of<CartProvider>(context, listen: false).removeOneGoods(item.goodsId);
            },
            child: Icon(Icons.delete_forever, color: Colors.black12, size: 30),
          )
        ],
      ),
    );
  }
}