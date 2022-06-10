import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/edit_admin_user_delivery_men_info.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/screens/user_orders_screen.dart';
import 'package:simo_v_7_0_1/screens/user_profile_screen.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/spalsh_screen_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/top_bar_widget_admins.dart';
import 'admin_show_products_edit_delet.dart';
import 'package:simo_v_7_0_1/uploadingImagesAndproducts.dart';

import 'cart_screen.dart';

class UserEditPassword extends StatefulWidget {
  static const String id = '/editUserPasswordt';

  @override
  _UserEditPasswordState createState() => _UserEditPasswordState();
}
class _UserEditPasswordState extends State<UserEditPassword> {

  TextEditingController controllerCurrentEmail = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerConfirmation = TextEditingController();








  final _formKeyEdit876556 = GlobalKey<FormState>();


  @override
  void dispose() {
    controllerCurrentEmail.dispose();
    controllerNewPassword .dispose();
    controllerConfirmation .dispose();

    super.dispose();
  }


  UserModel? userModel;

  getUserinfo() async {
    userModel = await GetUserOrAdminInfo().getUserInfo();
    setState(() {userModel;});
    // controllerEmail.text =userModel?.email==null ? controllerEmail.text :userModel!.email;
  }

  @override
  void initState() {
    getUserinfo();
    super.initState();
  }

  bool isLoading = false;
  final _formKeyEdit048546 = GlobalKey<FormState>();
  bool startLogingOut =false;

  @override
  Widget build(BuildContext context) {


    return userModel==null?
    Scaffold(body: SpinKitWave(color: Colors.green, size: 50.0,)):

    Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SafeArea(
                child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: () async {
                                Navigator.of(context).pop();
                              },
                                icon: Icon(Icons.arrow_back,),
                              ),],),


                          Container(
                              
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('Cambiar la contraseña ' ,style: TextStyle(fontSize: 24),)),
                              )),





                          SizedBox(height: 40,),
                          Expanded(
                              child: Form(
                                  key: _formKeyEdit048546,
                                  child: ListView(
                                      children: [
                                        SizedBox(height: 40,),
                                        TextFormField(
                                          controller:controllerCurrentEmail,
                                          obscureText:true,
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Este campo es obligatorio';
                                            } else {
                                              return null;}},
                                          decoration: InputDecoration(label: Text('Ingresar contraseña actual',
                                            style: TextStyle(fontSize: 20, color: Colors.blue),
                                          ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                                        ),
                                        SizedBox(height:20 ,),




                                        TextFormField(
                                          controller: controllerNewPassword,
                                          obscureText:true,
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Este campo es obligatorio';
                                            } else {
                                              return null;}},
                                          decoration: InputDecoration(label: Text(' Ingresar la Contraseña nueva',
                                            style: TextStyle(fontSize: 20, color: Colors.blue),
                                          ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                                        ),
                                        SizedBox(height:20 ,),

                                        TextFormField(
                                          controller:controllerConfirmation,
                                          obscureText:true,
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Este campo es obligatorio';
                                            } else {
                                              return null;}},
                                          decoration: InputDecoration(label: Text(' Confirmar la Contraseña actual',
                                            style: TextStyle(fontSize: 20, color: Colors.blue),
                                          ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                                        ),

                                        SizedBox(height: 40,),

                                        TextButton(onPressed:() async{

                                          if (_formKeyEdit048546.currentState!.validate()) {


                                            setState(() {isLoading =true;});
                                            var messgae =  await EditAdminAndUserDeliveryMenInfoApi().editUserPswrdUn(
                                                 id: userModel?.id==null?0:userModel!.id,
                                                 email:userModel?.email==null?'':userModel!.email,
                                                 oldPswrd:controllerCurrentEmail.text,
                                                 newPassword: controllerNewPassword.text,
                                                  confNewPswrd: controllerConfirmation.text);


                                            if(messgae!='El nombre de usuario y la contraseña se han cambiado con éxito'){


                                               controllerCurrentEmail.text = '';
                                              controllerNewPassword .text = '';
                                               controllerConfirmation .text = '';

                                               UsedWidgets().showNotificationDialogue(context,messgae.toString());

                                            } else{
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              UsedWidgets().showNotificationDialogue(context,messgae.toString());
                                            }

                                           setState(() {isLoading = false;});

                                          }}, child: isLoading==true?
                                        SpinKitWave(color: Colors.green, size: 50.0,):
                                        Text('Editar',style: TextStyle(fontSize: 20),))
                                      ])))])))));}






}
