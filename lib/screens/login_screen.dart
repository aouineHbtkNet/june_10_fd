import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/user_register_new_users.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:provider/provider.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'delivery_men_dashboard.dart';
import 'forget_password.screen.dart';


class LoginScreen extends StatefulWidget {
  static const String id = '/ login';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
     _emailController.dispose();
    _passwordController.dispose();


    super.dispose();
  }

  final _formKeyForLoginScreen = GlobalKey<FormState>();
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<ProviderOne>(context);

    return  WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key:_formKeyForLoginScreen,

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(height: 20,),
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

                      SizedBox(height: 20,),
                      Text('Ingresar a tu cuenta', style:
                      TextStyle(fontSize: 20, color: Color(0xFF00007f)  ),),
                      SizedBox(height: 20,),


                      UsedWidgets().emailValidation(textEditingController: _emailController,label: 'Ingresar tu correo electrónico'),
                      SizedBox(height: 40,),

                      UsedWidgets().passwordValidation(textEditingController: _passwordController,label: 'Ingresar tu contraseña'),

                      SizedBox(height: 8,),


                      SizedBox(height: 40,),

                     TextButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40.0),
                            shape: StadiumBorder()),
                        child: isLoading==true? CircularProgressIndicator(): Text('Enviar ', style: TextStyle(fontSize: 24,color: Color(0xFF00007f) )),


                        onPressed:() async{
                          if(_formKeyForLoginScreen.currentState!.validate()) {
                            setState(() {isLoading=true;});
                          String  destination= await ProviderOne().loginInForAllToFilter(_emailController.text, _passwordController.text);











                          if (destination=='admin'){
                               LoginResponseDataModel adminLoginResponse = LoginResponseDataModel();
                              adminLoginResponse = await ProviderOne().loginInForAdmins(_emailController.text, _passwordController.text);
                               await provider.addTableToSPA(destination);
                               await provider.addTokenToSPA(adminLoginResponse.token);
                               await provider.addUserIdToSPA(adminLoginResponse.id);
                               await provider.addUserNameToSPA(adminLoginResponse.name);
                               await provider.addUserEmailToSPA(adminLoginResponse.email);
                               await provider.addnUserMobilePhoneToSPA(adminLoginResponse.mobilePhone);
                               await provider.addnUserFixedPhoneToSPA(adminLoginResponse.fixedPhone);
                               await provider.addnUserAddressToSPA(adminLoginResponse.address);
                               await provider.addnUserNoDeIdToSPA(adminLoginResponse.nomDeId);
                               Navigator.pushNamed(context, AdminDashBoard.id);

                               setState(() {isLoading=false;});
                               showstuff(context, ' Hola ${adminLoginResponse.name}  , ingresaste a tu cuenta  ' );
                             }

                             if (destination=='user'){



                               LoginResponseDataModel userLoginResponse = LoginResponseDataModel();
                               userLoginResponse = await ProviderOne().loginInForUsers(_emailController.text, _passwordController.text);
                               await provider.addTableToSPA(destination);
                               await provider.addTokenToSPA(userLoginResponse.token);
                               await provider.addUserIdToSPA(userLoginResponse.id);
                               await provider.addUserNameToSPA(userLoginResponse.name);
                               await provider.addUserEmailToSPA(userLoginResponse.email);
                               await provider.addnUserMobilePhoneToSPA(userLoginResponse.mobilePhone);
                               await provider.addnUserFixedPhoneToSPA(userLoginResponse.fixedPhone);
                               await provider.addnUserAddressToSPA(userLoginResponse.address);
                               await provider.addnUserNoDeIdToSPA(userLoginResponse.nomDeId);
                               setState(() {isLoading=false;});




                               Navigator.pushNamed(context, UserCatalogue.id);
                               showstuff(context, ' Hola ${userLoginResponse.name}  , ingresaste a tu cuenta  ' );

                             }



                            if (destination=='deliveryman'){
                              LoginResponseDataModel deliveryManLoginResponse = LoginResponseDataModel();
                              deliveryManLoginResponse  = await ProviderOne().loginInForDeliveryMan(_emailController.text, _passwordController.text);
                              await provider.addTableToSPA(destination);
                              await provider.addTokenToSPA(deliveryManLoginResponse.token);
                              await provider.addUserIdToSPA(deliveryManLoginResponse.id);
                              await provider.addUserNameToSPA(deliveryManLoginResponse.name);
                              await provider.addUserEmailToSPA(deliveryManLoginResponse.email);
                              await provider.addnUserMobilePhoneToSPA(deliveryManLoginResponse.mobilePhone);
                              await provider.addnUserFixedPhoneToSPA(deliveryManLoginResponse.fixedPhone);
                              await provider.addnUserAddressToSPA(deliveryManLoginResponse.address);
                              await provider.addnUserNoDeIdToSPA(deliveryManLoginResponse.nomDeId);
                             Navigator.pushNamed(context, DeliveryMenDashboard.id);
                              setState(() {isLoading=false;});
                              showstuff(context, ' Hola ${deliveryManLoginResponse.name}  , ingresaste a tu cuenta  ' );
                            }













                             if(destination=='not found'){
                               setState(() {isLoading=true;});
                               showstuff(context, ' User or password $destination' );
                               setState(() {isLoading=false;});



                             }
                                else{ return;}
                          }
                          },






                      ),





                      SizedBox(height: 40,),

                      TextButton(
                        onPressed:() async{Navigator.pushNamed(context, RegisterNewUsers.id);},

                        child: Text('¿No tienes cuenta?', style: TextStyle(fontSize: 16 ,color: Color(0xFF00007f) ),),
                      ),
                     // SizedBox(height: 10,),
                      TextButton(
                        onPressed:() async{Navigator.pushNamed(context,ForgetPasswordScreen.id);},

                        child: Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 16 ,color: Color(0xFF00007f) ),),
                      ),




                    ],
                  ),
                )
            ),
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


