class UserModel {

  int id =0 ;
  String name='';
  String email ='';
  String  mobilePhone='';
  String  fixedPhone ='';
  String  address ='';
  String  identificationId ='';

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? id ;
    name = json['name']??name;
    email = json['email']?? email;
    mobilePhone = json['mobile_phone']??mobilePhone;
    fixedPhone = json['fixed_phone']?? fixedPhone;
    address = json['address']?? address;
    identificationId = json['identification_id']??identificationId;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_phone'] = this.mobilePhone;
    data['fixed_phone'] = this.fixedPhone;
    data['address'] = this.address;
    data['identification_id'] = this.identificationId;

    return data;
  }
}







