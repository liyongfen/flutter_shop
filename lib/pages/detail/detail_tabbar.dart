import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail_goods.dart';


class DetailTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MyTabbarItem> tabbar = [
      MyTabbarItem("详情", "detail"),
      MyTabbarItem("评论", "comment"),
    ];
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
      child: _myTabbar(context, tabbar),
    );
  }
  
  Widget _myTabbar(BuildContext context, List<MyTabbarItem> tabbar){
    String activeTabbar = Provider.of<DetailGoodsProvide>(context).activeTabbar;
    print(activeTabbar);
    return Row(
      children: <Widget>[
        _myTabbarItem(context, tabbar[0], 375, activeTabbar == tabbar[0].key),
        _myTabbarItem(context, tabbar[1], 375, activeTabbar == tabbar[1].key)
      ],
    );
  }

  Widget _myTabbarItem(BuildContext context, MyTabbarItem item, int width, bool isActive){
    return(
      InkWell(
        onTap: (){
          Provider.of<DetailGoodsProvide>(context, listen: false).changeTabbar(item.key);
        },
        child: Container(
          width: ScreenUtil().setWidth(width),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: isActive ? Colors.pink : Colors.black12
              )
            )
          ),
          child: Text(
            item.name,
            style: TextStyle(
              color: isActive ? Colors.pink : Colors.black
            ),
          ),
        ),
      )
    );
  }
}


class MyTabbarItem{
  String name;
  String key;
  MyTabbarItem(this.name, this.key);
}

