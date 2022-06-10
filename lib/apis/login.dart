import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Logins{

Future<LoginResponseDataModel> loginInForAdmins (String email,String password) async {
const Map<String, String> _loginHeader = {
'Content-Type': 'application/json',
'Accept': 'application/json',};
Uri _tokenUrl = Uri.parse(Constants.LOGIN_ADMIN);
Map<String, String> body = {'email': email, 'password': password};
http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
var data = jsonDecode(response.body);
LoginResponseDataModel adminLoginResponse = LoginResponseDataModel();
adminLoginResponse = LoginResponseDataModel.fromJson(data);
return adminLoginResponse;
}

Future<LoginResponseDataModel> loginInForUsers (String email,String password) async {
  const Map<String, String> _loginHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',};
  Uri _tokenUrl = Uri.parse(
      Constants.LOGIN_USER);
  Map<String, String> body = {'email': email, 'password': password};
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
  var data = jsonDecode(response.body);
  LoginResponseDataModel adminLoginResponse = LoginResponseDataModel();
  adminLoginResponse = LoginResponseDataModel.fromJson(data);
  return adminLoginResponse;
}










}