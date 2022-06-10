class LoginResponseDataModel {
  String table='';
  String message='';
  int id = 0;
  String name = '';
  String email = '';
  String mobilePhone = '';
  String fixedPhone = '';
  String address = '';
  String nomDeId = '';
  String token = '';


  LoginResponseDataModel();

  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) {
    LoginResponseDataModel loginResponseDataModel = LoginResponseDataModel();
    loginResponseDataModel.message = json["message"] ??'';
    loginResponseDataModel.table = json["table"] ??'';
    loginResponseDataModel.id = json["user"]["id"] ??'';
    loginResponseDataModel.name = json["user"]["name"]??'';
    loginResponseDataModel.email = json["user"]["email"]??'';
    loginResponseDataModel.mobilePhone = json["user"]["mobile_phone"] ??'';
    loginResponseDataModel.fixedPhone = json["user"]["fixed_phone"]??'';
    loginResponseDataModel.address = json["user"]["address"] ??'';
    loginResponseDataModel.nomDeId = json["user"]["identification_id"]??'';
    loginResponseDataModel.token = json["token"]??'';
    return loginResponseDataModel;
  }
}


