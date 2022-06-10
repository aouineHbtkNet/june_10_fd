import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/forget_password_users.dart';
import 'package:simo_v_7_0_1/apis/set_get_sharedPrefrences_functions.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/modals/send_code_recover_pswrd_response.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/screen_to_send_code.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/screens/user_register_new_users.dart';
import 'package:provider/provider.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';

import 'login_screen.dart';


class ForgetPasswordScreen extends StatefulWidget {
  static const String id = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}


class _ForgetPasswordScreenState extends State {

  TextEditingController _emailController = TextEditingController();

  final _formKeyForgetpassword = GlobalKey<FormState>();
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProviderOne>(context);
    return  WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        body: SafeArea(

          child: Form(
              key:_formKeyForgetpassword,
              child: SingleChildScrollView(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color:Color(0xFF329932), spreadRadius: 10)
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/app_logo.png'),
                              fit: BoxFit.cover,
                            ),),),
                      ),


                      SizedBox(height: 40,),

                      Text('Ingresar tu nombre de usuario', style:
                      TextStyle(fontSize: 20, color: Color(0xFF00007f)  ),
                      ),
                      SizedBox(height: 10,),
                      Text('El nombre de usuario es en un forma de un email ', style:
                      TextStyle(fontSize: 14, color: Colors.green, ),
                      ),
                      SizedBox(height: 40,),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.done,
                        controller: _emailController,
                        validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                        else if (value.isEmpty || !value.contains('@')) {return "Entrada invalida.Ex:example@example.com";}
                        else {return null;}},
                        decoration: InputDecoration(hintText: 'Example@mail.com', label: Text('Nombre de usuario',
                          style: TextStyle(fontSize: 20, color: Color(0xFF00007f) ),),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                      SizedBox(height: 40,),

                      TextButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40.0),
                            shape: StadiumBorder()),
                        child: isLoading==true? CircularProgressIndicator():Text('Enviar ', style: TextStyle(fontSize: 24,color: Color(0xFF00007f) )),


                        onPressed:() async{
                          if(_formKeyForgetpassword.currentState!.validate()) {
                            setState(() {isLoading=true;});
                            ResponseSentCodeModel  responseSentCodeModel = ResponseSentCodeModel();
                            responseSentCodeModel = await ForgetPassword().AskForACoDeViaEmail(email: _emailController.text );

                                 String emailTobesent =_emailController.text;
                            String? emailFromApi ='${responseSentCodeModel.selected_email}';
                             print('selected email  ===========${responseSentCodeModel.selected_email}');


                            if (responseSentCodeModel.code==1){

                                Navigator.push(context,
                                MaterialPageRoute(builder:
                                (context)=>ScreenToSendCodeAndNewPswrd (emailFromApi: responseSentCodeModel.selected_email),),);
                                UsedWidgets().showNotificationDialogue(context, responseSentCodeModel.message!);
                                setState(() {isLoading=false;});

                            }




                            else if  (responseSentCodeModel.code==0){
                              UsedWidgets().showNotificationDialogue(context, responseSentCodeModel.message!);
                              setState(() {isLoading=false;});}

                            else {
                              showstuff(context, 'Algo salió mal ');
                              setState(() {isLoading=false;});

                            }
                          }
                          },
   ),



                      SizedBox(height: 10,),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40.0),
                            shape: StadiumBorder()),
                        child: Text('¿Tienes una cuenta?', style: TextStyle(fontSize: 16 , color: Color(0xFF00007f) ),),
                        onPressed:() async{Navigator.pushNamed(context, LoginScreen.id);},
                      ),


                      TextButton(
                        onPressed:() async{Navigator.pushNamed(context, RegisterNewUsers.id);},

                        child: Text('¿ Quieres crear una cuenta nueva?', style: TextStyle(fontSize: 16 ,color: Color(0xFF00007f) ),),
                      ),


                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }

  //notification alert widget
  void showstuff(context, String mynotification) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Notification'),
            content: Text(mynotification),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pushNamedAndRemoveUntil(DisplayProductsToBeEdited.id, (Route<dynamic> route) => false);
                    // context.read<ProviderTwo>().initialValues();
                    // await context.read<ProviderTwo>().bringproductos();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

}


