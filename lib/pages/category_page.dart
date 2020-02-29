import 'package:flutter/material.dart';
import 'category/category_goods_list.dart';
import 'category/left_category_nav.dart';
import 'category/right_category_nav.dart';

class CategoryPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),centerTitle: true),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[ 
                RightCategoryNav(),
                GategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}