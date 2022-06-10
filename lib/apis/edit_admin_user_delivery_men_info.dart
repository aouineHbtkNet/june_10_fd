
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/modals/error_messgae_validate_register.dart';



class EditAdminAndUserDeliveryMenInfoApi {

// ======================================================================================USER===========================================

  Future editUserInfo({
    required int id,
    required String name,
    required String email,
    required String mobilePhone,
    required String fixedPhone,
    required String address,
    required String numIdentification,
    required String password,

  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    Uri _tokenUrl = Uri.parse(Constants.USER_EDIT_INFO);
    Map<String, dynamic> body =
    {
      'id': id,
      'name': name,
      'email': email,
      'mobilephone': mobilePhone,
      'fixedphone': fixedPhone,
      'address': address,
      'identification': numIdentification,
      'password': password
    };
    http.Response response = await http.post(
        _tokenUrl, headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);


    if (response.statusCode == 400) {
      ErrorMsgReisterValidate errorMsgReisterValidate = ErrorMsgReisterValidate();
      errorMsgReisterValidate = ErrorMsgReisterValidate.fromJson(data);

      String pswrd = errorMsgReisterValidate.password.toString();
      pswrd = pswrd.replaceAll("\[", "");
      pswrd = pswrd.replaceAll("\]", "");

      String name = errorMsgReisterValidate.name.toString();
      name = name.replaceAll("\[", "");
      name = name.replaceAll("\]", "");

      String email = errorMsgReisterValidate.email.toString();
      email = email.replaceAll("\[", "");
      email = email.replaceAll("\]", "");


      String address = errorMsgReisterValidate.address.toString();
      address =address.replaceAll("\[", "");
      address = address.replaceAll("\]", "");

      String mobilePhone = errorMsgReisterValidate.mobilephone.toString();
      mobilePhone  = mobilePhone .replaceAll("\[", "");
      mobilePhone  = mobilePhone .replaceAll("\]", "");

      String identifiCationNum = errorMsgReisterValidate.identification.toString();
      identifiCationNum = identifiCationNum .replaceAll("\[", "");
       identifiCationNum =  identifiCationNum .replaceAll("\]", "");



      String sum ='${name==''?'':name}${email==''?'':email}${pswrd==''?'':pswrd}${address==''?'':address}${mobilePhone==''?'':mobilePhone}${identifiCationNum ==''?'':identifiCationNum}';
      //
       print ('=name================${errorMsgReisterValidate.name}');
      print ('=email=================${errorMsgReisterValidate.email}');
      print ('=address=================${errorMsgReisterValidate.address}');
      print ('=mobile phone==================${errorMsgReisterValidate.mobilephone}');
      print ('=identification=================${errorMsgReisterValidate.identification}');
      print ('= password==================${errorMsgReisterValidate.password}');


     // print ('===========  sum  400 code ===============$sum==========================================');

      return sum;
    }
    if (response.statusCode == 201) {
      print ('data === 201==========$data');
      return data["message"];
    }
    else {

      print ('response from algo slaio mal =====Algo salió mal');
      return 'Algo salió mal';
    }
  }


  Future <String> editUserPswrdUn ({
    required int id,
    required String email,
    required String oldPswrd,
    required String newPassword,
    required String confNewPswrd,


  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    //// Route::post('user/edituserPaswdUnm', [ClientResourceController::class, 'modifyUserPswrdUn']);
    Uri _tokenUrl = Uri.parse(Constants.USER_EDIT_PSWRD_UN);
    Map<String, dynamic> body =
    {
      'id': id,
      'email': email,
      'oldPswrd': oldPswrd,
      'newPassword': newPassword,
      'cnfNewPassword': confNewPswrd,
    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print('message================================  ${data['message']}');
    return data['message'];
  }





// ======================================================================================ADMIN===========================================

  Future <String> editAdminInfo ({

    required int id,
    required String name,
    required String email,
    required String mobilePhone,
    required String fixedPhone,
    required String address,
    required String numIdentification,
    required String password,

  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
;
    Uri _tokenUrl = Uri.parse(Constants.ADMIN_EDIT_INFO);
    Map<String, dynamic> body =
    {
      'id': id,
      'name': name,
      'email': email,
      'mobilephone': mobilePhone,
      'fixedphone': fixedPhone,
      'address': address,
      'identification': numIdentification,
      'password':password
    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);

    if (response.statusCode == 400) {
      ErrorMsgReisterValidate errorMsgReisterValidate = ErrorMsgReisterValidate();
      errorMsgReisterValidate = ErrorMsgReisterValidate.fromJson(data);

      String pswrd = errorMsgReisterValidate.password.toString();
      pswrd = pswrd.replaceAll("\[", "");
      pswrd = pswrd.replaceAll("\]", "");

      String name = errorMsgReisterValidate.name.toString();
      name = name.replaceAll("\[", "");
      name = name.replaceAll("\]", "");

      String email = errorMsgReisterValidate.email.toString();
      email = email.replaceAll("\[", "");
      email = email.replaceAll("\]", "");

      String sum = '${name} \n ${email} \n${pswrd} ';
      print ('errors =============$sum');
      return sum;
    }
    if (response.statusCode == 201) {
      print ('data =============$data');
      return data["message"];
    }
    else {
      return 'Algo salió mal';
    }
  }



  Future <String> editAdminPswrdUn ({
    required int id,
    required String email,
    required String oldPswrd,
    required String newPassword,
    required String confNewPswrd,


  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    //// Route::post('user/edituserPaswdUnm', [ClientResourceController::class, 'modifyUserPswrdUn']);
    Uri _tokenUrl = Uri.parse(Constants.ADMIN_CHANGE_PASSWORD);
    Map<String, dynamic> body =
    {
      'id': id,
      'email': email,
      'oldPswrd': oldPswrd,
      'newPassword': newPassword,
      'cnfNewPassword': confNewPswrd,

    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print('message================================  ${data['message']}');
    return data['message'];
  }

// ======================================================================================DELIVERYMEN===========================================

  Future <String> editDeliveryAccountInfo ({

    required int id,
    required String name,
    required String email,
    required String mobilePhone,
    required String fixedPhone,
    required String address,
    required String numIdentification,
    required String password,

  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };


    Uri _tokenUrl = Uri.parse(Constants.DELIVERY_MEN_EDIT_INFO);
    Map<String, dynamic> body =
    {
      'id': id,
      'name': name,
      'email': email,
      'mobilephone': mobilePhone,
      'fixedphone': fixedPhone,
      'address': address,
      'identification': numIdentification,
      'password':password
    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    if (response.statusCode == 400) {
      ErrorMsgReisterValidate errorMsgReisterValidate = ErrorMsgReisterValidate();
      errorMsgReisterValidate = ErrorMsgReisterValidate.fromJson(data);

      String pswrd = errorMsgReisterValidate.password.toString();
      pswrd = pswrd.replaceAll("\[", "");
      pswrd = pswrd.replaceAll("\]", "");

      String name = errorMsgReisterValidate.name.toString();
      name = name.replaceAll("\[", "");
      name = name.replaceAll("\]", "");

      String email = errorMsgReisterValidate.email.toString();
      email = email.replaceAll("\[", "");
      email = email.replaceAll("\]", "");

      String sum = '${name} \n ${email} \n${pswrd} ';

      return sum;
    }
    if (response.statusCode == 201) {
      print ('data ==== 201=========$data');
      return data["message"];
    }
    else {
      return 'Algo salió mal';
    }
  }




  Future <String> editDeliveryAccountInfoByAdmin ({

    required int id,
    required String name,
    required String email,
    required String mobilePhone,
    required String fixedPhone,
    required String address,
    required String numIdentification,




  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };


    Uri _tokenUrl = Uri.parse(Constants.DELIVERY_MEN_EDIT_INFO_BY_ADMIN);
    Map<String, dynamic> body =
    {
      'id': id,
      'name': name,
      'email': email,
      'mobilephone': mobilePhone,
      'fixedphone': fixedPhone,
      'address': address,
      'identification': numIdentification,

    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    if (response.statusCode == 400) {
      ErrorMsgReisterValidate errorMsgReisterValidate = ErrorMsgReisterValidate();
      errorMsgReisterValidate = ErrorMsgReisterValidate.fromJson(data);

      String pswrd = errorMsgReisterValidate.password.toString();
      pswrd = pswrd.replaceAll("\[", "");
      pswrd = pswrd.replaceAll("\]", "");

      String name = errorMsgReisterValidate.name.toString();
      name = name.replaceAll("\[", "");
      name = name.replaceAll("\]", "");

      String email = errorMsgReisterValidate.email.toString();
      email = email.replaceAll("\[", "");
      email = email.replaceAll("\]", "");

      String sum = '${name} \n ${email} \n${pswrd} ';

      return sum;
    }
    if (response.statusCode == 201) {
      print ('data ==== 201=========$data');
      return data["message"];
    }
    else {
      return 'Algo salió mal';
    }
  }





















  Future <String> editDeliveryManPswrdUn ({
    required int id,
    required String email,
    required String oldPswrd,
    required String newPassword,
    required String confNewPswrd,


  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Uri _tokenUrl = Uri.parse(Constants.DELIVERY_MEN_CHANGE_PSSWRD );
    Map<String, dynamic> body =
    {
      'id': id,
      'email': email,
      'oldPswrd': oldPswrd,
      'newPassword': newPassword,
      'cnfNewPassword': confNewPswrd,

    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print('message================================  ${data['message']}');
    return data['message'];
  }


  Future <String> editDeliveryManPswrdUnByAdmin ({
    required int id,
    required String email,
    required String newPassword,
    required String confNewPswrd,


  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Uri _tokenUrl = Uri.parse(Constants.DELIVERY_MEN_CHANGE_PSSWRD_BY_ADMIN );
    Map<String, dynamic> body =
    {
      'id': id,
      'email': email,
      'newPassword': newPassword,
      'cnfNewPassword': confNewPswrd,

    };
    http.Response response = await http.post( _tokenUrl,headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print('message================================  ${data['message']}');
    return data['message'];
  }












}




















