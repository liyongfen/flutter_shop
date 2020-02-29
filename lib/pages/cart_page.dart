import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/pages/cart/cart_bottom.dart';
import 'package:provider/provider.dart';
import '../provide/cart.dart';
import 'cart/cart_item.dart';
import 'cart/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车'), centerTitle: true),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<CartModel> cartList = Provider.of<CartProvider>(context).cartList;
            print('购物车列表：${cartList.length}');
            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index){
                    return CartItem(cartList[index]);
                  }
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom()
                )
              ],
            );
          } else {
            return Text('数据加载中...');
          }
        }
      )
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return 'end';
  }
}



