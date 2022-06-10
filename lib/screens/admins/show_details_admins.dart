import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'change_pswrd_delivery_man_by_admin.dart';
import 'edit_delivery_men_by_admin.dart';



class
AdminsProfileScreenByAdmin extends StatefulWidget {
  static const String id = '/AdminsProfileScreenByAdmin';
  int? selectedId;
  AdminsProfileScreenByAdmin({this.selectedId});


  @override
  State<AdminsProfileScreenByAdmin> createState() => _AdminsProfileScreenByAdminState();
}

class _AdminsProfileScreenByAdminState extends State<AdminsProfileScreenByAdmin> {
  UserModel? userModel;
  @override
  void initState() {
     GetUserOrAdminInfo().getAdminInfoForAdmin(widget.selectedId??0).then((value){

      setState(() {userModel = value;});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () async {
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.arrow_back,),),


                    ],
                  ),
                ),


                Divider(thickness: 4,color: Colors.blueGrey,),
                SizedBox(height: 20,),

                userModel==null?SpinKitWave(color: Colors.green, size: 50.0,): Container(child: Column(
                  children: [

                    UsedWidgets().UserAccountScreen(title: 'Nombre :', data:userModel?.name),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'Nombre de usuario  ( tu email ):', data:userModel?.email,),
                    SizedBox(height:20 ,),
                    UsedWidgets().UserAccountScreen(title: 'celular :', data:userModel?.mobilePhone,),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'Telefono fijo :', data:userModel?.fixedPhone),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'Dirección :',data:userModel?.address,),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'N.de identificaion :',data:userModel?.identificationId,),
                    SizedBox(height: 20,),
                    Divider(thickness: 4,color: Colors.blueGrey,),

                  ],

                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}