import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart.dart';

class CartProvider with ChangeNotifier{
  List<CartModel> cartList = [];
  double allGoodsPrice = 0;
  int allGoodsCount = 0;
  bool allIsCheck = false;

  save(String goodsId, String goodsName, int count, double price, String images)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = cartString == null ? [] :  (json.decode(cartString.toString()) as List).cast();
    
    bool isHave = false;
    int index = 0;
    allGoodsPrice = 0;
    allGoodsCount = 0;

    tempList.forEach((item) {
      if(item['goodsId'] == goodsId){
        tempList[index]['count']++;
        cartList[index].count++;
        isHave = true;
      }
      if(item['isCheck']){
        allGoodsPrice += (price * tempList[index]['count']);
        allGoodsCount += tempList[index]['count'];
      }
      index++;
    });

    if(!isHave){ //没有则新加一个
      Map<String, dynamic> newGoods = {
        "goodsId": goodsId,
        "goodsName": goodsName,
        "count": count,
        "price": price,
        "images": images,
        "isCheck": true,
      };
      
      tempList.add(newGoods);
      cartList.add(CartModel.fromJson(newGoods));
      
      allGoodsPrice += (price*count);
      allGoodsCount += count;
      if(tempList.length == 1){
        allIsCheck = true;
      }
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }
   
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    allGoodsPrice = 0;
    allGoodsCount = 0;
    allIsCheck = false;
    notifyListeners();
  }

  getCartInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = cartString == null ? [] : (json.decode(cartString.toString()) as List).cast();

    cartList=[];
    allGoodsPrice = 0;
    allGoodsCount = 0;
    allIsCheck = true;


    tempList.forEach((item) {
      cartList.add(CartModel.fromJson(item));
      if(item['isCheck']){
        allGoodsCount += item['count'];
        allGoodsPrice += (item['count'] * item['price']);
      } else {
        allIsCheck = false;
      }
    });
    if(tempList.length == 0){
      allIsCheck = false;
    }
    
    print('allIsCheck:$allIsCheck');
    notifyListeners();
  }

  removeOneGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = cartString == null ? [] : (json.decode(cartString) as List).cast();

    int tempIndex = 0;
    int deleteIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(deleteIndex);
    prefs.setString('cartInfo', json.encode(tempList).toString());
    await getCartInfo();
  }

  changeCheckStatus(CartModel cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = cartString == null ? [] : (json.decode(cartString) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson();
    prefs.setString('cartInfo', json.encode(tempList).toString());
    await getCartInfo();
  }

  changeAllCheck(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = cartString == null ? [] : (json.decode(cartString) as List).cast();
    List<Map> newList = [];

    tempList.forEach((item){
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    });

    prefs.setString('cartInfo', json.encode(newList).toString());
    await getCartInfo();

  }
  addOrReduceAction(CartModel cartItem, String action) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = cartString == null ? [] : (json.decode(cartString) as List).cast();

    int index = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        if(action == 'add'){
          tempList[index]['count']++;
        } else if(action == 'reduce' && tempList[index]['count'] > 1){
          tempList[index]['count']--;
        }
      }
      index++;
    });
    
    prefs.setString('cartInfo', json.encode(tempList).toString());
    await getCartInfo();
  }
  
}