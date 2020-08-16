import 'dart:async';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Downloader{

  static Downloader _instance = new Downloader.internal();
  Downloader.internal();
  factory Downloader() => _instance;

  Future<String>downloadImg (String url, String filename)async{
    Dio dio=new Dio();
    //try{
    
    var dir= await getApplicationDocumentsDirectory();
    String savepath="${dir.path}/$filename";
    await dio.download(url,"${dir.path}/$filename");
    return savepath;
    //}catch(e)
   // {
     // print(e);
   // }
  }
}