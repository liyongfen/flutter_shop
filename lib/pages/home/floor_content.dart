import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class FloorContent extends StatelessWidget {
  final List<Map> content;
  FloorContent({Key key, this.content}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _secondRow(context)
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _footerItem(context, content[0], 500, 380),
          Column(
            children: <Widget>[
              _footerItem(context, content[1], 250, 130),
              _footerItem(context, content[2], 250, 130),
            ],
          )
        ],
      ),
    );
  }

  Widget _secondRow(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _footerItem(context, content[3], 250, 130),
          _footerItem(context, content[4], 250, 130),
        ],
      ),
    );
  }

  Widget _footerItem(BuildContext context ,Map item, int height, imgHeight) {
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${item['goodsId']}');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        height: ScreenUtil().setHeight(height),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.black12),
            bottom: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(colors: [
                    Color.fromRGBO(69, 202, 255, 1), 
                    Color.fromRGBO(20, 113, 251, 1)
                  ]).createShader(Offset.zero & bounds.size);
                },
                child: Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                    )
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item['subTitle'],
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(102, 103, 113, 1.0)),
                ),
                Text(
                  '￥${item['price']}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(102, 103, 113, 1.0)
                  ),
                )
              ],
            ),
            Image.network(
              item['image'],
              fit: BoxFit.fill,
              height: ScreenUtil().setHeight(imgHeight)
            ),
          ],
        ),
      ),
    );
  }
}
