import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../routers/application.dart';

class SwiperDiy extends StatelessWidget {

  final List<Map> swiperList;
  SwiperDiy({Key key, @required this.swiperList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, index){
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, '/detail?id=${swiperList[index]['goodsId']}');
            },
            child: Image.network('${swiperList[index]['image']}', fit: BoxFit.fill),
          );
        },
        itemCount: swiperList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}