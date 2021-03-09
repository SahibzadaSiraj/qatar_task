import 'package:http/http.dart' as http;
import 'package:task/service/api_contant.dart';

class ApiRequests {
  static Future<http.Response> getRequest({String endUrl}) async {
    String url = '${ApiConstant.baseUrl}$endUrl';
    var response = await http.get(url, headers: (ApiConstant.header));
    return response;
  }
}