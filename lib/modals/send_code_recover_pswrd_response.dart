
class ResponseSentCodeModel{

  String? message;
  int? code;
  String? selected_email;
  String? table;
  ResponseSentCodeModel();

  factory ResponseSentCodeModel.fromJason(Map<String,dynamic> json){

    Map<String, dynamic> emptyMap={};

    ResponseSentCodeModel responseSentCodeModel=ResponseSentCodeModel();
    responseSentCodeModel.message=json['message'] ??'' ;
    responseSentCodeModel.code=json['code']??2  ;
    responseSentCodeModel.selected_email=json['selected_email']??''  ;
    responseSentCodeModel.table=json['table']??''  ;

    return responseSentCodeModel;
  }
}
class SelectedUser{
  String? name;
  SelectedUser();
  factory SelectedUser.fromJason(Map<String,dynamic> json){
    SelectedUser selectedUser=SelectedUser();
    selectedUser.name=json['name'] ??'' ;

    return selectedUser;
  }





}