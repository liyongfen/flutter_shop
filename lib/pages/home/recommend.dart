import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class Recommend extends StatelessWidget {

  final List<Map> recommendList;
  Recommend({Key key, this.recommendList}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _titleWidget(),
          __recommendList(context)
        ],
      ),
    );
  }

  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10, top: 2, bottom: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
    );
  }
  Widget __recommendList(BuildContext context){
    return Container(
      height: ScreenUtil().setHeight(337),
      child: ListView.builder(
        //shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index){
          return _recommendItem(context, index);
        }
      ),
    );
  }
  Widget _recommendItem(BuildContext context, int index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
          height: ScreenUtil().setHeight(330),
          width: ScreenUtil().setWidth(250),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width:0.5, color:Colors.black12)
            )
          ),
          child: Column(
            children: <Widget>[
              Image.network(
                recommendList[index]['image'], 
                width: 250,
                height: 100,
              ),
              Text('￥${recommendList[index]['mallPrice']}'),
              Text(
                '￥${recommendList[index]['price']}', 
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey
                ),
              )
            ],
          ),
      ),
    );
  }
}