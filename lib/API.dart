import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://704288777faa.ngrok.io/api";

class API {
  static Future getUsers() {
    var url = baseUrl + "/stripes";
    return http.get(url);
  }
}
