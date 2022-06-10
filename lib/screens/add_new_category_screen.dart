import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/add_new_category.dart';
import 'package:simo_v_7_0_1/apis/api_add_new_product_admin.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/uploadingImagesAndproducts.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_functions.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'admin_profile_screen.dart';
import 'anadir_borrar_categorias_screen.dart';
import 'login_screen.dart';

class AdminAddNewCategoryScreen extends StatefulWidget {
  static const String id = '/adminAddNewCategoryScreen';
  @override _AdminAddNewCategoryScreenState createState() => _AdminAddNewCategoryScreenState();}

class _AdminAddNewCategoryScreenState extends State<AdminAddNewCategoryScreen> {
  final scaffoldKeyUnique = GlobalKey<ScaffoldState>();

  final _formKeyAddcategory1234 = GlobalKey<FormState>();
  String? categoryvalue;
  bool iSLoading = false;
  bool   done = false;


  var data;
  @override
  void initState() {

    super.initState();
  }

  TextEditingController controllerCategory = TextEditingController(text: '');


  @override
  void dispose() {
    controllerCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () async {Navigator.of(context).pop();},
                  icon: Icon(Icons.arrow_back, color: Colors.green,),),

              ],),

            SizedBox(height: 20,),

            // done == false || iSLoading == true ? SpinKitWave(color: Colors.green, size: 50.0,) :

            iSLoading == true ? SpinKitWave(color: Colors.green, size: 50.0,) :
            Expanded(

              child: Form(key:_formKeyAddcategory1234,
                child: Padding(padding: const EdgeInsets.all(8.0),
                  child: ListView(children: [SizedBox(height: 20,),



                   Container(child: Center(child: Text('Añadir una nueva categoría',style: TextStyle(fontSize: 20),)),),



                    SizedBox(height: 20,),

                    UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Ingresar el nombre ', textEditingController: controllerCategory),
                    SizedBox(height: 20,),

                    Padding(padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {

                          if (_formKeyAddcategory1234.currentState!.validate()) {
                            _formKeyAddcategory1234.currentState!.save();


                            if (controllerCategory.text != null) {

                              setState(() {iSLoading = true;});

                              String message12 =await  AddNewcategory().addNewcategory(controllerCategory.text);

                               Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(AdminAddDeleteCategories.id);
                              Navigator.of(context).pushNamed(AdminAddNewCategoryScreen.id);

                              setState(() {
                                controllerCategory.text='';
                                iSLoading =false;});
                              UsedWidgets().showNotificationDialogue(context, message12);






                            } else {
                              UsedWidgets().showNotificationDialogue(context,'El texto es vacio .Intenta de nuevo');

                            }













                          }
                        },
                        child: Text('Enviar'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
              ),),


          ],),
      ),





    );
  }


}