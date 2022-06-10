
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/cart_screen.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';

import 'package:simo_v_7_0_1/widgets_utilities/user_app_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';






class GetProduct {
  Future <List <Product> >  getProductsList() async


  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');



    final Map<String, String> _userprofileHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    print (spToken);

    Uri _tokenUrl = Uri.parse(Constants.GET_PRODUCT_USER);
    http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader);
    var jsondata = jsonDecode(response.body) as List;
   print ( 'raw_data =============================${jsondata}');

     List<Product> list = jsondata.map((product) =>Product.fromJason(product)).toList();
        int i =0;
       for(var e in list){ print ('${++i}=============== ${e.categoria_id}'); }


    print ('list=============================${list}');
    return list;




  }
}