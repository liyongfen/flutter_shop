import 'package:flutter/material.dart';
import '../model/category.dart';
//混入
class ChildCategoryProvide with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];
  int childCategoryIndex = 0;
  String mallCategoryId = '4';//大类ID
  String mallSubId = ''; //子类ID
  int page = 1;
  String noMoreText = '';

  setChildCategory(List<BxMallSubDto> list, categoryId) {
    BxMallSubDto all = BxMallSubDto(
      mallSubId: '00', 
      mallCategoryId: '00',
      mallSubName: '全部', 
      comments: ''
    );
    
    childCategoryList = [all];
    childCategoryList..addAll(list);

    childCategoryIndex = 0; //重置子类索引
    mallCategoryId = categoryId; //更新大类ID
    mallSubId = ''; //点击大类，子类ID置空
    
    page=1; 
    noMoreText = ''; 
    notifyListeners();
  }

  changeChildIndex(int index, String id){
    childCategoryIndex = index;
    mallSubId = id;

    page=1; 
    noMoreText = ''; 
    notifyListeners();
  }
  addPage(){
    page++;
  }
  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
}