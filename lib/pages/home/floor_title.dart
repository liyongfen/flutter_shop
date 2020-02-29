import 'package:flutter/material.dart';

class FloorTitle extends StatelessWidget {
  final String titleImage;
  FloorTitle({Key key, this.titleImage}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Image.network(titleImage),
    );
  }
}