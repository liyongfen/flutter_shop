import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provider/provider.dart';
import '../../model/category.dart';
import '../../provide/child_category.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    final ChildCategoryProvide childCategory = Provider.of<ChildCategoryProvide>(context);
    
    return Container(
      height: ScreenUtil().setHeight(75),
      width: ScreenUtil().setWidth(570),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: childCategory.childCategoryList.length,
        itemBuilder: (context, index){
          return _rightCategoryItem(childCategory.childCategoryList[index], index);
        }
      ),
    );
  }

  Widget _rightCategoryItem(BxMallSubDto item, int index){
    bool isActiveChildCategory = (index == Provider.of<ChildCategoryProvide>(context).childCategoryIndex) ? true : false;
    
    return InkWell(
      onTap: (){
        Provider.of<ChildCategoryProvide>(context, listen: false).changeChildIndex(index, item.mallSubId);
        _getCategoryGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 5),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            color: isActiveChildCategory ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }
  /**
   * 子类按钮，获取商品列表数据
   */
  void _getCategoryGoodsList(String mallSubId)async {
    
    FormData formData = new FormData.fromMap({
      "mallCategoryId": Provider.of<ChildCategoryProvide>(context, listen: false).mallCategoryId,
      "mallSubId": Provider.of<ChildCategoryProvide>(context, listen:false).mallSubId, 
      'page': 1,
    });

    await request('categoryGoodList',formData: formData).then((data){
      if(data == null){
        Provider.of<CategoryGoodsListProvide>(context,listen: false).setCategoryGoodsList([]);
      } else {
        List<CategoryGoodsModel> newData = []; 
       data.forEach((v) => newData.add(CategoryGoodsModel.fromJson(v)));
        Provider.of<CategoryGoodsListProvide>(context,listen: false).setCategoryGoodsList(newData);
      }
    });
  }
}