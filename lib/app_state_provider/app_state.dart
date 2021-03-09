import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task/model/task_model.dart';
import 'package:task/service/api_service.dart';

class DataService with ChangeNotifier{
  List<TaskModel> _dataList=[];
  bool _pagination=false;
  int _page=1;

  set dataList(v){
    _dataList=v;
    notifyListeners();
  }
  set page(v){
    _page=v;
    notifyListeners();
  }
  set pagination(v){
    _pagination=v;
    notifyListeners();
  }
  List<TaskModel> get dataList=>_dataList;
  bool get pagination=>_pagination;
  int get page=>_page;

  DataService(){
    getData(nextPage: 1);
  }

  getData({int nextPage})async{

    Response response=await ApiRequests.getRequest(endUrl: "api/species/?page=$nextPage");
  Map<String,dynamic> data=jsonDecode(response.body);
    if(data['detail']=="Not found"){
      print("No data available");
    }
    else{
      data["results"].forEach((v){
        _dataList.add(TaskModel.fromJson(v));
      });
    }
    print(_dataList.length);
    _pagination=false;
    notifyListeners();
  }

}