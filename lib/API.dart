import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://290b920a521f.ngrok.io/api";

class API {
  static Future getUsers() {
    var url = baseUrl + "/stripes";
    return http.get(url);
  }
}
