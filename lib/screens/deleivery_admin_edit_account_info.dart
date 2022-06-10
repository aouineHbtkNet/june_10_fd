import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/edit_admin_user_delivery_men_info.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'admin_show_products_edit_delet.dart';


class DeliveryEditAccount extends StatefulWidget {
  static const String id = '/DeliveryEditAccount37353';

  @override
  _DeliveryEditAccountState createState() => _DeliveryEditAccountState();
}
class _DeliveryEditAccountState extends State<DeliveryEditAccount> {

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerMobilePhone = TextEditingController();
  TextEditingController controllerFixedPhone = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController ControllerIdNumber = TextEditingController();
  TextEditingController ControllerPassword = TextEditingController();




  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerMobilePhone.dispose();
    controllerFixedPhone.dispose();
    controllerAddress.dispose();
    ControllerIdNumber.dispose();
    super.dispose();
  }


  UserModel? userModel;

  getUserinfo() async {
    userModel = await GetUserOrAdminInfo().getDeliveryMenInfo();
     setState(() {userModel;});
     print('usermodel ${userModel?.name}');
    controllerName.text =userModel?.name==null ? controllerName.text:userModel!.name;
    controllerEmail.text =userModel?.email==null ? controllerEmail.text :userModel!.email;
    controllerMobilePhone.text =userModel?.mobilePhone==null ?  controllerMobilePhone.text :userModel!.mobilePhone;
    controllerFixedPhone.text =userModel?.fixedPhone==null ? controllerFixedPhone.text :userModel!.fixedPhone;
    controllerAddress.text =userModel?.address==null ? controllerAddress.text  :userModel!.address;
    ControllerIdNumber.text =userModel?.identificationId==null ? ControllerIdNumber.text :userModel!.identificationId;
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
                                child: Center(child: Text('Editar el perfil ' ,style: TextStyle(fontSize: 24),)),
                              )),
                          SizedBox(height: 20,),
                          isLoading ==true || userModel==null?
                          SpinKitWave(color: Colors.green, size: 50.0,):  Expanded(
                              child: Form(
                                  key: _formKeyEdit048546,
                                  child: ListView(
                                      children: [

                                        SizedBox(height:20 ,),
                                        UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Nombre completo', textEditingController:controllerName,),
                                        SizedBox(height:20 ,),
                                        Icon(Icons.warning_amber_rounded,color: Colors.red,),
                                        UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Nombre de usuario', textEditingController:controllerEmail,),
                                        Text('Necesita tu nombre de usuario para ingresar a tu cuenta y también para recuperar tu contraseña',
                                          style: TextStyle(fontSize: 16,color: Colors.red),),
                                        SizedBox(height:20 ,),
                                        UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Celular', textEditingController:controllerMobilePhone,),
                                        SizedBox(height:20 ,),
                                        UsedWidgets().userinfofielsEmtyenabled(label: 'Teefono fijo', textEditingController:controllerFixedPhone,),
                                        SizedBox(height:20 ,),
                                        UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Dirreccion', textEditingController:controllerAddress,),
                                        SizedBox(height:20 ,),
                                        UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'N.de identificacion', textEditingController:ControllerIdNumber,),
                                        SizedBox(height:20 ,),


                                        TextFormField(
                                          controller: ControllerPassword,
                                          obscureText:true,
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Este campo es obligatorio';
                                            } else {
                                              return null;}},
                                          decoration: InputDecoration(label: Text(' Ingresar tu contraseña',
                                            style: TextStyle(fontSize: 20, color: Colors.blue),
                                          ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                                        ),
                                        SizedBox(height:20 ,),

                                        ElevatedButton(onPressed:() async {
                                          if (_formKeyEdit048546.currentState!.validate()) {
                                            setState(() {isLoading = true;});


                                            var response= await EditAdminAndUserDeliveryMenInfoApi().editDeliveryAccountInfo(
                                                id: userModel?.id == null ? 0 : userModel!.id,
                                                name: controllerName.text,
                                                email: controllerEmail.text,
                                                mobilePhone: controllerMobilePhone.text,
                                                fixedPhone: controllerFixedPhone.text,
                                                address: controllerAddress.text,
                                                numIdentification: ControllerIdNumber.text,
                                                password: ControllerPassword.text);

                                            if(response =='Editado con éxito .'){
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              showstuff(context,response.toString());
                                              setState(() {isLoading = false;});
                                            }


                                            else if(response =='la contarsena no esta correcta .'){
                                             showstuff(context,response.toString());
                                             setState(() {isLoading = false;});
                                            }

                                            else if(response =="Algo salió mal"){
                                              showstuff(context,response.toString());
                                              setState(() {isLoading = false;});
                                            }

                                            else{
                                              showstuff(context,response.toString());
                                              setState(() {isLoading = false;});
                                            }

                                          }

                                        }, child:  Text('editar'),


                                        ),
                                      ]
                                  )

                              ))])))));}


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
                  child: Text('Ok')),
            ],
          );
        });
  }



}
