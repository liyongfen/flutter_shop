import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class HotGoods extends StatelessWidget {
  final String title;
  final List<Map> list;
  HotGoods({Key key, this.title, this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          _hotTitle(), 
          _hotList(context)
        ],
      ),
    );
  }

  Widget _hotTitle(){
    return Container(
      child: Image.network(title),
    );
  }

  Widget _hotList(context){
    if(list.length == 0){
      return Text('');
    }
    return Wrap(
      spacing: 3,
      children: list.map((item){
        return _hotItem(context, item);
      }).toList(),
    );
    
  }

  Widget _hotItem(BuildContext context, Map item){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${item['goodsId']}');
      },
      child: Container(
        width: ScreenUtil().setWidth(361),
        margin: EdgeInsets.only(bottom:3),
        padding: EdgeInsets.only(left: 5, right: 5),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Image.network(item['image']),
            Text(
              item['title'],
              overflow: TextOverflow.ellipsis, 
              maxLines: 2,
              style: TextStyle(color: Colors.pink,)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('￥${item['mallPrice']}'),
                Text('￥${item['price']}', 
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black12
                )),
              ]
            )
          ],
        ),
      ),
    ); 
  }
}