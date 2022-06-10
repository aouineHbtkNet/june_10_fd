import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';

import 'admin_login_response_model.dart';

class GetAllAdminsUsersDeliveryMenPg{
  List<Member> listOfMembers=[];
  int total=0;
  GetAllAdminsUsersDeliveryMenPg();


  factory  GetAllAdminsUsersDeliveryMenPg.fromjson(Map<String,dynamic> json){

    GetAllAdminsUsersDeliveryMenPg getAllAdminsUsersDeliveryMenPg =GetAllAdminsUsersDeliveryMenPg();

    getAllAdminsUsersDeliveryMenPg.total = json['memebers']['total'];

    for( var member  in json[ "memebers"]["data"]){
      Member temp =Member.fromJson(member);
      getAllAdminsUsersDeliveryMenPg.listOfMembers.add(temp);}

    return getAllAdminsUsersDeliveryMenPg;
  }
}


class Member {
  int id = 0;
  String name = '';
  String email = '';
  String mobilePhone = '';
  String fixedPhone = '';
  String address = '';
  String nomDeId = '';
  Member();

  factory Member.fromJson(Map<String, dynamic> json) {
    Member loginResponseDataModel = Member();
    loginResponseDataModel.id = json["id"] ??'';
    loginResponseDataModel.name = json["name"]??'';
    loginResponseDataModel.email = json["email"]??'';
    loginResponseDataModel.mobilePhone = json["mobile_phone"] ??'';
    loginResponseDataModel.fixedPhone = json["fixed_phone"]??'';
    loginResponseDataModel.address = json["address"] ??'';
    loginResponseDataModel.nomDeId = json["identification_id"]??'';
    return loginResponseDataModel;
  }
}