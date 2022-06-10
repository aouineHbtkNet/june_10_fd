import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/edit_admin_user_delivery_men_info.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';


class AdminEditPassword extends StatefulWidget {
  static const String id = '/Admin90853UserPasswordt';

  @override
  _AdminEditPasswordState createState() => _AdminEditPasswordState();
}
class _AdminEditPasswordState extends State<AdminEditPassword> {

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

  GetAdminInfo() async {
    userModel = await GetUserOrAdminInfo().getAdminInfo();
    setState(() {userModel;});
    // controllerEmail.text =userModel?.email==null ? controllerEmail.text :userModel!.email;
  }

  @override
  void initState() {
    GetAdminInfo();
    super.initState();
  }

  bool isLoading = false;
  final _formKeyEdklkj = GlobalKey<FormState>();
  bool startLogingOut =false;

  @override
  Widget build(BuildContext context) {




    print(' -----------------------------------------------------${userModel?.email}');

    return Scaffold(
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
                          isLoading ==true || userModel==null?
                          SpinKitWave(color: Colors.green, size: 50.0,):  Expanded(
                              child: Form(
                                  key: _formKeyEdit876556,
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

                                          if (_formKeyEdit876556.currentState!.validate()) {


                                            setState(() {isLoading =true;});
                                            var messgae =  await EditAdminAndUserDeliveryMenInfoApi().editAdminPswrdUn(
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
