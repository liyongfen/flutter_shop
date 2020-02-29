import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import './pages/index_page.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/detail_goods.dart';
import './provide/cart.dart';
import './provide/current_index.dart';
import './routers/routes.dart';
import './routers/application.dart';



void main(){
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //路由
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MultiProvider(
      providers: [//这里是关键注册通知
        ChangeNotifierProvider(create: (_) => ChildCategoryProvide()),
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvide()),
        ChangeNotifierProvider(create: (_) => DetailGoodsProvide()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
      ],
      child: Container(
        child: MaterialApp(
          title: '百姓生活+',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.pink
          ),
          home: IndexPage()
        ),
      )
    );
  }
}