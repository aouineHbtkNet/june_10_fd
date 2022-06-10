import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/modals/items_in_cart_for_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/cart_response_list.dart';
class GetOrderListOfProducts{

// Route::post('/getOrderListOfProductsDeliveryMen', [DeliveryMenController::class, 'getOrderListOfProducts']);


  Future <CartResponse> getOrderItemsDeliveryMen( int? orerId ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    final url = Uri.parse('https://hbtknet.com/repartidor/getOrderListOfProductsDeliveryMen');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {'order_id': orerId,};
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    var jsondata = jsonDecode(response.body) ;

    CartResponse cartResponse = CartResponse ();
    cartResponse=CartResponse.fromjson(jsondata);

    return cartResponse ;
  }
 // Route::post('/getOrderListOfProductsUsers', [ClientResourceController::class, 'getOrderListOfProducts']);
  Future <CartResponse> getOrderItemsUsers( int? orerId ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    final url = Uri.parse('https://hbtknet.com/client/getOrderListOfProductsUsers');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {'order_id': orerId,};
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    var jsondata = jsonDecode(response.body) ;

    CartResponse cartResponse = CartResponse ();
    cartResponse=CartResponse.fromjson(jsondata);

    return cartResponse ;
  }














  Future <CartResponse> getOrderItemsAdmins( int? orerId ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    final url = Uri.parse('https://hbtknet.com/admin/getOrderListOfProducts');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Map<String, dynamic> body = {'order_id': orerId,};
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    var jsondata = jsonDecode(response.body) ;

    CartResponse cartResponse = CartResponse ();
    cartResponse=CartResponse.fromjson(jsondata);

    return cartResponse ;
  }


}

