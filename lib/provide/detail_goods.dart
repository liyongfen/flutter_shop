import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../model/detail_goods.dart';

class DetailGoodsProvide with ChangeNotifier{
  DetailGoodsModel detailGoods = null;
  String activeTabbar = 'detail';//comment

  getDetailGoodsInfo(String id) async{
    await request('detailGoods', formData: FormData.fromMap({"goodsId": id})).then((data){
      if(data != null){
        detailGoods = DetailGoodsModel.fromJson(data);
        print('得到详情页数据');
        notifyListeners();
      }
    });
  }

  changeTabbar(String changeState){
    activeTabbar = changeState;
    notifyListeners();
  }
}