import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';
import 'package:simo_v_7_0_1/modals/order_detail_model.dart';




class ModifyStatusAndDomiciliario{



  Future  modifySatatus(
      int orderId,
      String status,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');

    print('sptoken ========================$spToken');

    final url = Uri.parse('https://hbtknet.com/admin/modifystatus/$orderId');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {
      'status':status,

    };
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    var jsonData = jsonDecode(response.body) ;

    // var jsonData = jsonDecode(response.body) as List;
    // List<OrderDetailModel> list =jsonData.map((product) =>OrderDetailModel.fromJson(product)).toList();
    print('jsondata====================$jsonData');

    return jsonData ;
  }




  Future  modifyDomiciliario(
      int orderId,
      String domicilirioid,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');

    print('sptoken ========================$spToken');

    final url = Uri.parse('https://hbtknet.com/admin/modifydeliverymanid/$orderId');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {
      'deliverymanid':domicilirioid,

    };
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    var jsonData = jsonDecode(response.body) ;

    print('jsondata====================$jsonData');

    return jsonData ;
  }

















}
