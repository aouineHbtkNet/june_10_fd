import 'dart:convert';
import 'dart:io';
import 'package:simo_v_7_0_1/apis/future_functions_SP.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';

import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/modals/error_messgae_validate_register.dart';

import 'package:simo_v_7_0_1/modals/loginEndpointApiResponseFile.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/modals/user_response_update.dart';


enum States { initial, loading, loaded }

class ProviderOne extends ChangeNotifier {



  States state = States.initial;



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

//=================================================logOutUsers   4/2/2022 used ok  =========================

 Future<bool> logOutUsers(String mytoken) async {
  Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $mytoken',};

  Uri _tokenUrl = Uri.parse(Constants.LOGOUT_USER);
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader,);
  var data = jsonDecode(response.body);
  return true;
 }


// ============================== loginForUsers  OK =======================

 Future<LoginEndpointApiResponseModel> getLoginEndpointApiResponse(String email,
     String password) async {

  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
  };
  Uri _tokenUrl = Uri.parse('http://10.0.2.2:8000/api_v_1/public/publicapi/admin/login');
  Map<String, String> body = {'email': email, 'password': password};


  http.Response response = await http.post(
      _tokenUrl, headers: _loginHeader, body: jsonEncode(body));

  var data = jsonDecode(response.body);

  LoginEndpointApiResponseModel loginEndpointApiResponseModel = LoginEndpointApiResponseModel();
  loginEndpointApiResponseModel = LoginEndpointApiResponseModel.fromJson(data);

  return loginEndpointApiResponseModel;
 }




 //==================================addTableToSPA new    ================================
 addTableToSPA(String value) async {
  await FutureFunctionsSP().addTableToSPB(value);
  state = States.loaded;
  notifyListeners();
 }
//==================================addTokenToSPA 4/2/2022 used ok   ================================


 addTokenToSPA(String value) async {
  await FutureFunctionsSP().addTokenToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

















//================================== getSPToken() 4/2/2022 used ok ================================
 String? spToken = '';

 getSPToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  spToken = prefs.getString('spToken');
  notifyListeners();
 }

 

//================================== addUserNameToSPA  2/4/2022 used ok  ================================

 addUserNameToSPA(String value) async {
  await FutureFunctionsSP().addUserNameToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

 //================================== addUserPhone 2/4/2022 used ok  ================================

 addUserPhoneToSPA(String value) async {
  await FutureFunctionsSP().addUserPhoneToSPB(value);
  state = States.loaded;
  notifyListeners();
 }














//================================== addUserAddress 2/4/2022 used ok  ================================

 addUserAddressToSPA(String value) async {
  await FutureFunctionsSP().addUseraddressToSPB(value);
  state = States.loaded;
  notifyListeners();
 }




 //=====================new    start


 addnUserAddressToSPA(String value) async {
  await FutureFunctionsSP().addUserAddressToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

 addnUserMobilePhoneToSPA(String value) async {
  await FutureFunctionsSP().addUserMobilePhoneToSPB(value);
  state = States.loaded;
  notifyListeners();
 }






 addnUserFixedPhoneToSPA(String value) async {
  await FutureFunctionsSP(). addUserFixedPhoneToSPB(value);
  state = States.loaded;
  notifyListeners();
 }


 addnUserNoDeIdToSPA(String value) async {
  await FutureFunctionsSP().addUserNoDeIdToSPB(value);
  state = States.loaded;
  notifyListeners();
 }












 //========================new    end















 //==============================   getuserNameFromSP   4/2/2022 used ok  =======================================

 String userNameFromSharedPtreferences = '';

 getuserNameFromSP() async {
  userNameFromSharedPtreferences =
  await FutureFunctionsSP().getuserNameFromSP();
  state = States.loaded;
  notifyListeners();
 }

//==============================================addUserEmailToSPA    4/2/2022   used ok ============================
 addUserEmailToSPA(String value) async {
  await FutureFunctionsSP().addUserEmailToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

//================================== getuserEmailFromSP 4/2/2022 used ok  ========================================
 String emailFromSharedPtreferences = '';
 getuserEmailFromSP() async {
  emailFromSharedPtreferences =
  await FutureFunctionsSP().getuserEmailFromSP();
  state = States.loaded;
  notifyListeners();
 }

//==================================== addUserIdToSPA 4/2/2022 used ok  =======================================

 addUserIdToSPA(int value) async {
  await FutureFunctionsSP().addUserIdToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

//==================================getuserIdFromSP 4/2/2022 used ok  ========================================
 int idFromSharedPtreferences = 0;
 getuserIdFromSP() async {
  idFromSharedPtreferences = await FutureFunctionsSP().getuserIdFromSP();
  state = States.loaded;
  notifyListeners();
 }





 //================================ registerforUsers  4/2/2022 used ok  ===================================================

 Future  registerForUsers   (String name ,String email,String password) async {
  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
  };
  Uri _tokenUrl = Uri.parse(Constants. REGISTER_USER );
  Map<String, String> body = {
   'name':name,
   'email': email,
   'password': password};
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
  var data = jsonDecode(response.body);

  if(response.statusCode==400){
   ErrorMsgReisterValidate errorMsgReisterValidate= ErrorMsgReisterValidate();
   errorMsgReisterValidate =ErrorMsgReisterValidate.fromJson(data);
   String pswrd = errorMsgReisterValidate.password.toString();
   pswrd = pswrd.replaceAll("\[", "");
   pswrd= pswrd.replaceAll("\]", "");

   String name = errorMsgReisterValidate.name.toString();
   name = name.replaceAll("\[", "");
   name= name.replaceAll("\]", "");

   String email = errorMsgReisterValidate.email.toString();
   email= email.replaceAll("\[", "");
   email= email.replaceAll("\]", "");

   String sum = '${name} \n ${email} \n${pswrd} ';
   return sum ;
  }
  if(response.statusCode==201){
   LoginResponseDataModel loginResponse = LoginResponseDataModel();
   loginResponse = LoginResponseDataModel.fromJson(data);
   return  loginResponse;
  }
  else {


   return 'Algo salió mal';}



 }












 //================================ UpdateAllUserInformation 4/2/2022 used ok  ===================================================


























//================================ registerAdmins   4/2/2022 used ok  ===================================================

 Future<LoginResponseDataModel> registerAdmins   (String name ,String email,String password) async {
  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
  };
  Uri _tokenUrl = Uri.parse('http://192.168.1.22/api_v_1/public/publicapi/admin/register');
  Map<String, String> body = {
   'name':name,
   'email': email,
   'password': password};

  http.Response response = await http.post(
      _tokenUrl,
      headers: _loginHeader,
      body: jsonEncode(body));

  var data = jsonDecode(response.body);

  LoginResponseDataModel adminLoginResponse = LoginResponseDataModel();
  adminLoginResponse = LoginResponseDataModel.fromJson(data);

  return adminLoginResponse;
 }




 // ============================== loginTo check everyone     4/2/2022=======================


 Future <String> loginInForAllToFilter (String email,String password) async {
  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',};
  Uri _tokenUrl = Uri.parse(Constants.ALL_LOGIN_T0_FILTER);
  Map<String, String> body = {'email': email, 'password': password};
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));

 String data = jsonDecode(response.body);


  return data;
 }








 
 // ============================== loginInForAdmins   OK  4/2/2022=======================
 

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



 Future <LoginResponseDataModel>  loginInForDeliveryMan (String email,String password) async {
  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',};
  Uri _tokenUrl = Uri.parse('https://hbtknet.com/publicapi/delivery/login');
  Map<String, String> body = {'email': email, 'password': password};
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
  var data = jsonDecode(response.body);



  LoginResponseDataModel adminLoginResponse = LoginResponseDataModel();
  adminLoginResponse = LoginResponseDataModel.fromJson(data);
print ('token  delivery man account ==============${adminLoginResponse.token}');

  return adminLoginResponse;
 }












//========================== logoutOutAdmins 04/2/2022 used ok ==========================

 Future<bool> logoutOutAdmins(String mytoken) async {

  Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $mytoken',
  };
  Uri _tokenUrl = Uri.parse(Constants.LOGOUT_ADMIN);
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader,);
  var data = jsonDecode(response.body);
  
  return true;
 }

 Future<bool> logoutOutDeliveryMen
     (String mytoken) async {

  Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $mytoken',
  };
  Uri _tokenUrl = Uri.parse(Constants.LOGOUT_DELIVERY_MAN );
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader,);
  var data = jsonDecode(response.body);

  print(' answer from logout delevery man ${data}');

  return true;
 }






 //========================== logoutOutUsers 04/2/2022 used ok ==========================

 Future<bool> logoutOutUsers(String mytoken) async {

  Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $mytoken',
  };
  Uri _tokenUrl = Uri.parse(Constants.LOGOUT_USER);
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader,);
  var data = jsonDecode(response.body);
    if (response.statusCode==200 && data['message']=='logged out'){
         return true;
    }
  print(' response from logout user ===============${data}');

  return false;
 }









}

