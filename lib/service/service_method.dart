import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import './service_url.dart';
import '../config/http_headers.dart';

Future request(url, {formData}) async{
  try {
    Response response;
    var dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded').toString();
    
    print('请求接口：${pathService[url]}');
    
    if(formData == null){
      response = await dio.post(pathService[url]);
    } else {
      response = await dio.post(
        pathService[url], 
        data: formData,
      );
    }
    
    var res = json.decode(response.data);
    if(res['status'] == 1){
      return res['data'];
    } else {
      throw Exception('后台接口异常');
    }

  } catch (e) {
    return print('ERROR:======>$e');
  }
}

Future getHttpJike()async{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.headers= httpHeadersJike;
    response =await dio.get(pathService['jike']);
    print(response.data);
    return response.data;
  }catch(e){
    return print(e);
  }
}

Future getHttpTest(String text) async{
  try {
    print('开始请求=======');
    var dio = new Dio();
    Response response = await dio.get(pathService['test'], 
      queryParameters: {"name": text}
    );
    var res = json.decode(response.data);
    return res['data'];
  } catch (e) {
    //print(e);
    return e;
  }
}
