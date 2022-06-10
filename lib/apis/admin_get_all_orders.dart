import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';

class GetAllOrdersAdmin{
  Future <List>  getOrdersAdmin(

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');

    final url = Uri.parse(Constants.GET_ORDERS_FOR_Admins);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    final response = await http.post(url, headers: headers);
    var jsondata = jsonDecode(response.body) ;
     // var jsondata = jsonDecode(response.body) as List;
     //List list =jsondata.map((product) =>Product.fromJason(product)).toList();
    print (' response from getOrderAdmin function ==================$jsondata');
    return  jsondata;
  }





  Future <List>  getOrderWithDetailsAdmin(

      int order_id

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');

    final url = Uri.parse(Constants.GET_ORDERS_WITH_DETAILS_FOR_Admins);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {'order_id':order_id,};


    final response = await http.post(url, headers: headers,body: jsonEncode(body));
   // var jsondata = jsonDecode(response.body) ;

    var jsondata = jsonDecode(response.body) as List;
    //List list =jsondata.map((product) =>Product.fromJason(product)).toList();
     print ('orders with all details ==================$jsondata');

    return  jsondata;
  }




  Future <List>  getOrderWithDetailsAdminNoFilter( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');

    final url = Uri.parse(Constants.GET_ORDERS_WITH_DETAILS_FOR_Admins_N0_FILTER);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    final response = await http.post(url, headers: headers);
    // var jsondata = jsonDecode(response.body) ;

    var jsondata = jsonDecode(response.body) as List;
    //List list =jsondata.map((product) =>Product.fromJason(product)).toList();

   // print ('from the functionmmmmmmmmmmmmmmmmmmmmmmmmmmm ==================$jsondata');

    return  jsondata;
  }







}




