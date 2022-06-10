import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class ModifyStatusForDomiciliarios{



//Route::post('/modifystatusfordeliverymen/{id}', [DeliveryMenControlle::class, 'modifystatus']);
  Future  setToStatusForDomiciliarios(
      int orderId,
      String status,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');

    print('sptoken ========================$spToken');

    final url = Uri.parse('https://hbtknet.com/repartidor/modifystatusfordeliverymen/$orderId');
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



}




















