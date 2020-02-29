import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './router_handler.dart';

class Routes{
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router){
    //404路由
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('#######: not fuond page');
      }
    );
    //详情页路由
    router.define(detailsPage, handler: detailHandler);
  }
}