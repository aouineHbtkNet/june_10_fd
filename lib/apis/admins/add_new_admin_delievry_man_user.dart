import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/error_messgae_validate_register.dart';

class AddNewAdminUsersDeliveryManByAdmin{

  Future  addNewAdminByAdmin   (
  {
    required String name ,
    required String email,
    required String password,
    required String fixedPhone ,
    required String mobilePhone,
    required String address,
    required String identificationId
}
) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    print('Got token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Uri _tokenUrl = Uri.parse(Constants.ADD_NEW_ADMIN );
    Map<String, String> body = {
      'name':name,
      'email': email,
      'password': password,
      'mobile_phone': mobilePhone,
      'fixed_phone': fixedPhone,
      'address':address,
      'identification_id': identificationId
    };
    http.Response response = await http.post(_tokenUrl, headers:headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);

    print ('response from the function register new admin $data');

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
      return  loginResponse.message;
    }
    else {return 'Algo salió mal';}

  }



  Future  addNewDEliveryManByAdmin   (
      {
        required String name ,
        required String email,
        required String password,
        required String fixedPhone ,
        required String mobilePhone,
        required String address,
        required String identificationId
      }
      ) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    print('Got token');



    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Uri _tokenUrl = Uri.parse(Constants.ADD_NEW_DELIVERY_MAN );
    Map<String, String> body = {
      'name':name,
      'email': email,
      'password': password,
      'mobile_phone': mobilePhone,
      'fixed_phone': fixedPhone,
      'address':address,
      'identification_id': identificationId
    };
    http.Response response = await http.post(_tokenUrl, headers:headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);

    print ('response from the function register new delivery man  $data');

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
      return  loginResponse.message;
    }
    else {return 'Algo salió mal';}

  }


  Future  addNewUserByAdmin   (
      {
        required String name ,
        required String email,
        required String password,
        required String fixedPhone ,
        required String mobilePhone,
        required String address,
        required String identificationId
      }
      ) async {

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Uri _tokenUrl = Uri.parse(Constants.REGISTER_USER );
    Map<String, String> body = {
      'name':name,
      'email': email,
      'password': password,
      'mobile_phone': mobilePhone,
      'fixed_phone': fixedPhone,
      'address':address,
      'identification_id': identificationId
    };
    http.Response response = await http.post(_tokenUrl, headers:headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);

    print ('response from the function register new user $data');

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
      return  loginResponse.message;
    }
    else {return 'Algo salió mal';}

  }







}