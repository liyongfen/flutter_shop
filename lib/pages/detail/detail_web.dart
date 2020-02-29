import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_goods.dart';

class DetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsDetail = Provider.of<DetailGoodsProvide>(context).detailGoods.goodsInfo.goodsDetail;
    String activeTabbar = Provider.of<DetailGoodsProvide>(context).activeTabbar;

    if(activeTabbar == 'detail'){
      return Container(
        child: Html(
          data: goodsDetail
        ),
      );
    } else if(activeTabbar == 'comment'){
      return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: Text(
          '暂时没有数据'
        ),
      );
    }
  }
}