import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';

class DeleteOrder{

  Future  deleteOrder(int order_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');

    final url = Uri.parse(Constants. DELETE_ORDER);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {'order_id':order_id,};
    final response = await http.post(url, headers: headers,body: jsonEncode(body));
    var jsondata = jsonDecode(response.body);
    print ('from delete function $jsondata');
    return jsondata;
  }



}



