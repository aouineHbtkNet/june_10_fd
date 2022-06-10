import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';

class GetUserOrAdminInfo{

  Future<UserModel>   getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');
    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/client/get_user_info');
    Map<String, dynamic> body = {'id':id,};
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
       var data = jsonDecode(response.body);
      UserModel userModel = UserModel();
      userModel = UserModel.fromJson(data);
      return  userModel;}



  Future<UserModel>   getUserInfoByAdmin(  int? selectedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');

    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/get_user_info');
    Map<String, dynamic> body = {'id':selectedId,};
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    UserModel userModel = UserModel();
    userModel = UserModel.fromJson(data);
    return  userModel;}














  Future<UserModel>   getAdminInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');
    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/getadmininfo');
    Map<String, dynamic> body = {'id':id,};
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    UserModel userModel = UserModel();
    userModel = UserModel.fromJson(data);
    return  userModel;}



  Future<UserModel> getDeliveryMenInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    int? id = await prefs.getInt('id');
    print('sptoken ========================$spToken');
    print('id ========================$id');
    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/repartidor/getdeliverymen');
    Map<String, dynamic> body = {'id':id,};
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print(' profile deleivery man ===========${data}');
    UserModel userModel = UserModel();
    userModel = UserModel.fromJson(data);
    return  userModel;}











  Future<UserModel> getDeliveryMenInfoForAdmin(int? selectedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');


    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/getdeliverymen');
    Map<String, dynamic> body = {'id':selectedId,};
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print(' profile deleivery man ===========${data}');
    UserModel userModel = UserModel();
    userModel = UserModel.fromJson(data);
    return  userModel;}




  Future<UserModel> getAdminInfoForAdmin( int? selectedId ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    Map<String, String> _loginHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/get_admin_info');
    Map<String, dynamic> body = {'id':selectedId};
    http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print(' profile deleivery man ===========${data}');
    UserModel userModel = UserModel();
    userModel = UserModel.fromJson(data);
    return  userModel;}













}









