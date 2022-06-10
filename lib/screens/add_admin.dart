import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/user_register_new_users.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:provider/provider.dart';
import 'forget_password.screen.dart';


class AddAdminForm extends StatefulWidget {
  static const String id = '/AddAdminForm';
  const AddAdminForm({Key? key}) : super(key: key);
  @override
  _AddAdminFormState createState() => _AddAdminFormState();
}


class _AddAdminFormState extends State {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobilePhoneController = TextEditingController();
  TextEditingController _fixedPhoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _identificationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKeyForLoginScreen = GlobalKey<FormState>();
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProviderOne>(context);

    return  Scaffold(

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

                    IconButton(onPressed: () async {

                      Navigator.of(context).pop();
                    },
                      icon: Icon(Icons.arrow_back,color: Colors.green,),
                    ),
                    SizedBox(height: 20,),


                    SizedBox(height: 20,),
                    Text('Ingresar a tu cuenta', style:
                    TextStyle(fontSize: 20, color: Color(0xFF00007f)  ),),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.done,
                      controller: _emailController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else if (value.isEmpty || !value.contains('@')) {return "Entrada invalida.Ex:example@example.com";}
                      else {return null;}},
                      decoration: InputDecoration(hintText: 'Ingresar tu correo electrónico', label: Text('Correo electrónico',
                        style: TextStyle(fontSize: 20,color: Color(0xFF00007f) ),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                    SizedBox(height: 8,),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else {return null;}},
                      decoration: InputDecoration(hintText: ' Ingresar tu contraseña', label: Text('Contraseña',
                          style: TextStyle(fontSize: 20, color: Color(0xFF00007f)  )),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
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


