import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdBanner extends StatelessWidget {
  final String adBannerImage;
  AdBanner({Key key, @required this.adBannerImage}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(70),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Image.network(adBannerImage),
        ],
      )
    );
  }
}