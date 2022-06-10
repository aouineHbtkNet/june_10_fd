import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simo_v_7_0_1/apis/admins/add_new_admin_delievry_man_user.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';


class AddNewDeliveryMan extends StatefulWidget {
  static const String id = '/AddNewDeliveryMan';

  @override
  State<AddNewDeliveryMan> createState() => _AddNewDeliveryManState();
}

class _AddNewDeliveryManState extends State<AddNewDeliveryMan> {


  void showstuff(context, String mynotification) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            content: Text(mynotification),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))],);});
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _mobilePhoneController = TextEditingController();
  TextEditingController _fixedPhoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _identificationIdController = TextEditingController();



  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController .dispose();
    _mobilePhoneController.dispose();
    _fixedPhoneController.dispose();
    _addressController.dispose();
    _identificationIdController.dispose();
    super.dispose();
  }


  emptyFields(){
    setState(() {
      _nameController.text='';
      _emailController.text='';
      _passwordController.text='';
      _confirmPasswordController .text='';
      _mobilePhoneController.text='';
      _fixedPhoneController.text='';
      _addressController.text='';
      _identificationIdController.text='';
    });

  }
  final _addnewadminkey= GlobalKey<FormState>();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderOne>(context);
    return Scaffold(
      body: SafeArea(
        child:
        Column(
          children: [

            Row(children: [IconButton(onPressed: () async {Navigator.of(context).pop();},
              icon: Icon(Icons.arrow_back,color: Colors.green,),),],),
            Divider(thickness: 2,color: Colors.blueGrey,),
            SizedBox(height: 20,),
            Text('Agregar un nuevo repartidor', style: TextStyle(fontSize: 20, color: Color(0xFF00007f)  ),),
            SizedBox(height: 20,),
            Divider(thickness: 2,color: Colors.blueGrey,),

            Expanded(
              child: Form(key:_addnewadminkey,
                  child: Padding(padding: const EdgeInsets.all(8.0), child: ListView(
                    children: [
                      SizedBox(height: 40,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Nombre completo', textEditingController:_nameController,),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'email', textEditingController:_emailController,),
                      SizedBox(height: 20,),

                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                        else if (value.length<8){ return 'La contraseña debe tener al menos 8 caracteres.'; }
                        else {return null;}},
                        decoration: InputDecoration(hintText: 'Ingresar  contraseña', label: Text(' Contraseña',
                          style: TextStyle(fontSize: 20 ,color: Colors.blue),),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),

                      SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                        controller: _confirmPasswordController,
                        validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                        else if (_confirmPasswordController.text!=_passwordController.text){ return 'contraseña y confirmación no coinciden'; }
                        else {return null;}},
                        decoration: InputDecoration(hintText: 'Confirmar la contraseña', label: Text('Confirmar la contraseña',
                          style: TextStyle(fontSize: 20 ,color: Colors.blue),),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                      SizedBox(height: 20,),
                      UsedWidgets().userinfofielsEmtyenabled(label: 'Telefono fijo', textEditingController:_fixedPhoneController,),
                      SizedBox(height:20 ,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Teléfono móvil', textEditingController:_mobilePhoneController,),
                      SizedBox(height:20 ,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Dirección', textEditingController:_addressController,),
                      SizedBox(height:20 ,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Número de identificación', textEditingController:_identificationIdController,),
                      SizedBox(height:20 ,),

                      TextButton(
                        child: isLoading==true? CircularProgressIndicator():
                        Container(
                            decoration: BoxDecoration(color: Color(0xFF00007f) ,borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Enviar ', style: TextStyle(fontSize: 24,color:Colors.white )),
                            )),

                        onPressed:() async{
                          if (_addnewadminkey.currentState!.validate()) {
                            setState(() {isLoading=true;});
                            LoginResponseDataModel userLoginResponse = LoginResponseDataModel();

                            var response = await AddNewAdminUsersDeliveryManByAdmin().addNewDEliveryManByAdmin(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                fixedPhone: _fixedPhoneController.text,
                                mobilePhone: _mobilePhoneController.text,
                                address:_addressController.text,
                                identificationId: _identificationIdController.text);

                            if(response == ' Creacion de una cuenta de admin  nueva con éxito  '){
                              emptyFields();
                              showstuff(context,response.toString());
                              setState(() {isLoading = false;});
                            }
                            else  if(response =='Algo salió mal' ){
                              emptyFields();
                              showstuff(context,response.toString());
                              setState(() {isLoading = false;});
                            }
                            else{
                              emptyFields();
                              showstuff(context,response.toString());
                              setState(() {isLoading = false;});
                            }

                          }
                        },
                      ),
                      SizedBox(height:20 ,),
                    ],
                  ),
                  )
              ),
            ),
          ],
        ),

      ),

    );
  }
}