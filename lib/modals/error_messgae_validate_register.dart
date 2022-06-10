class ErrorMsgReisterValidate {
  List ? name;
  List ? email;
  List ? password;
  List ? address;
  List ? mobilephone;
  List ? identification;


  ErrorMsgReisterValidate();

  factory ErrorMsgReisterValidate.fromJson(Map <String, dynamic> json) {
    ErrorMsgReisterValidate errorMsgReisterValidate =ErrorMsgReisterValidate();
    errorMsgReisterValidate. name = json['errors']['name'] ?? [] ;
    errorMsgReisterValidate. email = json['errors']['email']?? [];
    errorMsgReisterValidate. password = json['errors']['password']?? [];

    errorMsgReisterValidate. address = json['errors']['address']?? [];
    errorMsgReisterValidate. mobilephone = json['errors']['mobilephone']?? [];
    errorMsgReisterValidate. identification = json['errors']['identification']?? [];







    return errorMsgReisterValidate;
  }

}