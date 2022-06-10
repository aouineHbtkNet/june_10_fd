import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/edit_admin_user_delivery_men_info.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';


class ChangePswrdDeliveryByAdmin extends StatefulWidget {
  static const String id = '/ChangePswrdDeliveryByAdmin';
  int? selectedId;
  ChangePswrdDeliveryByAdmin({this.selectedId});


  @override
  _ChangePswrdDeliveryByAdminState createState() => _ChangePswrdDeliveryByAdminState();
}
class _ChangePswrdDeliveryByAdminState extends State<ChangePswrdDeliveryByAdmin> {

  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerConfirmation = TextEditingController();

  final _formKeyEdit876556 = GlobalKey<FormState>();
  @override
  void dispose() {
    controllerNewPassword .dispose();
    controllerConfirmation .dispose();

    super.dispose();
  }


  UserModel? userModel;

  GetDeliveryMenInfo() async {
    userModel = await GetUserOrAdminInfo().getDeliveryMenInfoForAdmin(widget.selectedId);
    setState(() {userModel;});

  }

  @override
  void initState() {
    GetDeliveryMenInfo();
    super.initState();
  }

  bool isLoading = false;

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
                              child:userModel?.name==null?SizedBox(height: 0,) :Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('Cambiar la contraseña de ${userModel?.name}' ,style: TextStyle(fontSize: 18),)),
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
                                          decoration: InputDecoration(label: Text(' Confirmar la Contraseña nueva',
                                            style: TextStyle(fontSize: 20, color: Colors.blue),
                                          ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                                        ),

                                        SizedBox(height: 40,),

                                        TextButton(onPressed:() async{

                                          if (_formKeyEdit876556.currentState!.validate()) {


                                            setState(() {isLoading =true;});
                                            var messgae =  await EditAdminAndUserDeliveryMenInfoApi().editDeliveryManPswrdUnByAdmin(
                                                id: userModel?.id==null?0:userModel!.id,
                                                email:userModel?.email==null?'':userModel!.email,
                                                newPassword: controllerNewPassword.text,
                                                confNewPswrd: controllerConfirmation.text);


                                            if(messgae!='El nombre de usuario y la contraseña se han cambiado con éxito'){


                                              controllerNewPassword .text = '';
                                              controllerConfirmation .text = '';

                                              UsedWidgets().showNotificationDialogue(context,messgae.toString());

                                            } else{
                                              controllerNewPassword .text = '';
                                              controllerConfirmation .text = '';
                                              UsedWidgets().showNotificationDialogue(context,messgae.toString());
                                            }

                                            setState(() {isLoading = false;});

                                          }}, child: isLoading==true?
                                        SpinKitWave(color: Colors.green, size: 50.0,):
                                        Text('Editar',style: TextStyle(fontSize: 20),))
                                      ])))])))));}






}
