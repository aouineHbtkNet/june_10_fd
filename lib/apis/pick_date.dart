
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






class PickDate {

  Future  pickDate( BuildContext context) async {

    final initialdate= DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialdate,
        firstDate:DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5) );

    if(newDate==null)return;


  }
}