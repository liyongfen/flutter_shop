import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopNavigator extends StatelessWidget {
  final List<Map> topNavigatorList;
  TopNavigator({Key key, @required this.topNavigatorList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(310),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        mainAxisSpacing: 5,
        children: topNavigatorList.map((item){
          return _gridViewItem(context, item);
        }).toList()
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, item){
    return InkWell(
      onTap: (){ print('点击了');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Padding(padding: EdgeInsets.only(top:3), child: Text(item['mallCategoryName']))
        ],
      ),
    );
  }
}