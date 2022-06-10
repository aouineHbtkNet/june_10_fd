import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';

class GetAllCategoriesAdmin {
  Future  getCategoriesAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');

    final url = Uri.parse(Constants.GET_ALL_CATEGORIES);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    final response = await http.post(url, headers: headers);
    var jsondata = jsonDecode(response.body) as List;


    // // List list =jsondata.map((product) =>jsondata['nombre_categoria'].toList();
    // List list =jsondata.map((category) {
    //
    //   jsondata['nombre_categoria'];
    //
    //
    // }).toList();

    print(' response from getOrderAdmin function ==================$jsondata');
    return jsondata;
  }
}