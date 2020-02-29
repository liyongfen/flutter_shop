import 'package:flutter/material.dart';
import '../model/category_goods.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryGoodsModel> categoryGoodsList = [];

  setCategoryGoodsList(List<CategoryGoodsModel> list) {
    categoryGoodsList = list;
    print(categoryGoodsList.length);
    notifyListeners();
  }
  setMoreCategoryGoodsList(List<CategoryGoodsModel> list) {
    categoryGoodsList.addAll(list);
    notifyListeners();
  }
}