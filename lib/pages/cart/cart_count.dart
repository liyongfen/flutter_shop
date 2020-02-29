import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provider/provider.dart';

class CartCount extends StatelessWidget {
  final CartModel item;
  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(context),
          _addBtn(context)
        ],
      ),
    );
  }

  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        if(item.count > 1){
          Provider.of<CartProvider>(context, listen: false).addOrReduceAction(item, 'reduce');
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        Provider.of<CartProvider>(context, listen: false).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Text('+'),
      ),
    );
  }

  Widget _countArea(context){
    return Container(
      height: ScreenUtil().setHeight(45),
      width: ScreenUtil().setWidth(70),
      alignment: Alignment.center,
      child: Text('${item.count}'),
    );
  }
}