import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/category_goods_list.dart';
import '../../provide/child_category.dart';
import '../../service/service_method.dart';
import '../../model/category.dart';
import '../../model/category_goods.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryModel> leftCategoryList = [];
  int activeIndex = 0;

  @override
  void initState() { 
    super.initState();
    _getCategory();
    _getCategoryGoodsList();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.5, 
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        itemCount: leftCategoryList.length,
        itemBuilder: (context, index){
          return _leftCategoryItem(index);
        }
      ),
    );
  }
  
  Widget _leftCategoryItem(int index){
    bool isActiveCategory = activeIndex == index ? true : false;
    return InkWell(
      onTap: (){
        var chiledList = leftCategoryList[index].bxMallSubDto;
        var mallCategoryId = leftCategoryList[index].mallCategoryId;
        
        setState(() {
          activeIndex = index;
        });
        //更新子类
        Provider.of<ChildCategoryProvide>(context, listen: false).setChildCategory(chiledList, mallCategoryId);
        //获取商品列表
        _getCategoryGoodsList(mallCategoryId: mallCategoryId);
      },
      child:  Container(
        padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
        decoration: BoxDecoration(
          color: isActiveCategory ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black12
            )
          )
        ),
        child: Text(
          leftCategoryList[index].mallCategoryName
        ),
      ),
    );
  }

  void _getCategory()async {
    await request('category').then((data){
      List<CategoryModel> newData = []; 
      data.forEach((v) {
        newData.add(CategoryModel.fromJson(v));
      });
      setState(() {
        leftCategoryList = newData;
      });
      Provider.of<ChildCategoryProvide>(context, listen: false).setChildCategory(newData[0].bxMallSubDto, newData[0].mallCategoryId);
    });
  }

  /**
   * 大类按钮，获取商品列表
   */
  void _getCategoryGoodsList({String mallCategoryId})async {

    FormData formData = new FormData.fromMap({
      "mallCategoryId": mallCategoryId == null ? '4': mallCategoryId,  
      "mallSubId": '', 
      'page': 1,
    });

    await request('categoryGoodList',formData: formData).then((data){
      if(data == null || data.length == 0){
        Provider.of<CategoryGoodsListProvide>(context,listen: false).setCategoryGoodsList([]);
      } else {
        List<CategoryGoodsModel> newData = []; 
        data.forEach((v) => newData.add(CategoryGoodsModel.fromJson(v)));
        Provider.of<CategoryGoodsListProvide>(context,listen: false).setCategoryGoodsList(newData);
      }
    });
  }
}