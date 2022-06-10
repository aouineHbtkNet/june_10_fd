import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
 import 'dart:io';
import 'package:http/http.dart' as http;

class AddNewcategory{

  Future  <String>  addNewcategory(String categia) async {
    var json;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    print('Got token');

    final url = Uri.parse(Constants.ADD_NEW_PRODUCT);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    Map<String, String> body = {
      'nombre_categoria': categia,
    };

    final response = await post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201) // first if

        {
      try {
        json = jsonDecode(response.body);

      } catch (e)
          {

      }
    }

    return json['message'];
  }






}


















