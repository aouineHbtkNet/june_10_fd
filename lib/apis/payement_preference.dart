import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/modals/user_response_update.dart';


class PayementPreference{



  Future <String>  getPaymentId(
      // String unitPrice ,
      double unitPrice ,
      String name ,
      String email ,

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');
    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/publicapi/getapi');
    Map<String, dynamic> body = {
       'unit_price':unitPrice,
       'name':name,
       'email':email,
    };
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));



    var data = jsonDecode(response.body);
   // print ('data ======================${data}');
     var payementid =data['id'];
    print ('payementid from payemetIdFunction  ======================${payementid}');
    return  payementid.toString() ;


  }
}

