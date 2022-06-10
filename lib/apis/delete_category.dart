import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';

class DeleteCategory{

  Future <String>  deleteOrder(int category_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    final url = Uri.parse('https://hbtknet.com/admin/deleteacategory');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {'category_id':category_id,};
    final response = await http.post(url, headers: headers,body: jsonEncode(body));
    var jsondata = jsonDecode(response.body);
    print ('from delete function $jsondata');
    return jsondata['message'];
  }



}