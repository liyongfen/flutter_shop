import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('会员中心'),centerTitle: true),
      body: ListView(
        children: <Widget>[
          _topHead(),
          _orderTitle(),
          _orderType(),
          _actionList(),
          _otherList(),
        ],
      ),
    );
  }

  Widget _topHead(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(

            width: ScreenUtil().setWidth(200),
            //height: ScreenUtil().setHeight(200),
            margin: EdgeInsets.only(top: 30, bottom: 10),
            child: ClipOval(
              child: Image.network('http://n.sinaimg.cn/default/transform/393/w550h643/20200227/8543-ipzreiw7065543.jpg'),
            ),
          ),
          Container(
            child: Text(
              '李勇芬',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(33),
                color: Colors.black54
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5, color: Colors.black12
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.view_list),
        title: Text('我的订单'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode, size: 30,),
                Text('待付款')
              ],
            ),
          ),
          //==============
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder, size: 30,),
                Text('待发货')
              ],
            ),
          ),
          //==============
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car, size: 30,),
                Text('待收货')
              ],
            ),
          ),
          //==============
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste, size: 30,),
                Text('待评价')
              ],
            ),
          ),
          //==============
        ],
      ),
    );
  }

  Widget _listTileItem(String title){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: ListTile(
        title: Text(title),
        leading: Icon(Icons.assignment),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _listTileItem('领取优惠券'),
          _listTileItem('已领取优惠券'),
          _listTileItem('地址管理'),
        ],
      ),
    );
  }

  Widget _otherList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _listTileItem('客服电话'),
          _listTileItem('关于我们'),
        ],
      ),
    );
  }
}