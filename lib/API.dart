import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://2e788e7ba3dc.ngrok.io/api";

class API {
  static Future getNewStripes() {
    var url = baseUrl + "/stripes";
    return http.get(url);
  }
}
