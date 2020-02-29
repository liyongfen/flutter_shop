import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../provide/category_goods_list.dart';
import '../../provide/child_category.dart';
import '../../service/service_method.dart';
import '../../model/category_goods.dart';
import '../../routers/application.dart';

class GategoryGoodsList extends StatefulWidget {
  @override
  _GategoryGoodsListState createState() => _GategoryGoodsListState();
}

class _GategoryGoodsListState extends State<GategoryGoodsList> {
  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryGoodsListProvide goodsProvider = Provider.of<CategoryGoodsListProvide>(context);

    if(goodsProvider.categoryGoodsList.length == 0){
      return Text('暂时没有数据');
    }
    // var scrollController = ScrollController();
    // try{
    //   if(Provider.of<ChildCategoryProvide>(context).page==1){
    //     scrollController.jumpTo(0);
    //   }
    // }catch(e){
    //   print('进入页面第一次初始化：${e}');
    // }
    // //到底部了
   
    return Expanded(
      child: Container(
        width: ScreenUtil().setWidth(570),
        color: Colors.white,
        child: EasyRefresh(
          child: ListView.builder(
            //controller: scrollController,
            itemCount: goodsProvider.categoryGoodsList.length,
            itemBuilder: (context, index){
              return _categoryGoodItem(context, goodsProvider.categoryGoodsList[index], index);
            }
          ),
          onLoad: () async{
            //先调用页码增加的方法
            Provider.of<ChildCategoryProvide>(context, listen:false).addPage();
            FormData formData = new FormData.fromMap({
              "mallCategoryId": Provider.of<ChildCategoryProvide>(context, listen: false).mallCategoryId,
              "mallSubId": Provider.of<ChildCategoryProvide>(context, listen: false).mallSubId, 
              'page': Provider.of<ChildCategoryProvide>(context, listen: false).page, 
            });

            request('categoryGoodList',formData: formData).then((data){
              if(data == null){
                Provider.of<CategoryGoodsListProvide>(context,listen: false).setCategoryGoodsList([]);
              } else {
                List<CategoryGoodsModel> newData = []; 
                data.forEach((v) => newData.add(CategoryGoodsModel.fromJson(v)));

                if(newData.length == 0){
                  Provider.of<ChildCategoryProvide>(context, listen: false).changeNoMore('没有更多数据了');
                  Fluttertoast.showToast(
                    msg: '没有更多数据了',
                    textColor: Colors.white,
                    backgroundColor: Colors.black54,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 14,
                  );
                } else {
                  Provider.of<CategoryGoodsListProvide>(context,listen: false).setMoreCategoryGoodsList(newData);
                }
              }
            });
          },
        )
      ),
    );
  }

  Widget _categoryGoodItem(BuildContext context, CategoryGoodsModel item,int index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${item.goodsId}');
      },
      child: Container(
        width: ScreenUtil().setWidth(570),
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(item, index),
            Column(
              children: <Widget>[
                _goodsName(item, index),
                _goodsPrice(item, index)
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _goodsImage(CategoryGoodsModel item, int index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(item.image),
    );
  }

  Widget _goodsName(CategoryGoodsModel item, int index){
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.only(right: 10),
      child: Text(
        item.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _goodsPrice(CategoryGoodsModel item, int index){
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '价格:￥${item.presentPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.pink
            )
          ),
          Text(
            '￥${item.oriPrice}',
            style: TextStyle(
              color: Colors.black12,
              fontSize: ScreenUtil().setSp(26),
              decoration: TextDecoration.lineThrough
            )
          ),
        ],
      )
    );
  }


}