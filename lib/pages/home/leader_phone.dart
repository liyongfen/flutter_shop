import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      color: Colors.white,
      child: InkWell(
        onTap: _launcherUrl,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launcherUrl() async{
    String urlString = 'tel:' + leaderPhone;
    print('点击了');
    if(await canLaunch(urlString)){
      await launch(urlString);
    } else {
      throw '电话不能拨打';
    }
  }
}