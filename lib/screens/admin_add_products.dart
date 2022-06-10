import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/add_new_category.dart';
import 'package:simo_v_7_0_1/apis/api_add_new_product_admin.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/modals/product_and_categories_paginated.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/uploadingImagesAndproducts.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_functions.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'admin_profile_screen.dart';
import 'login_screen.dart';

class AdminAddProduct extends StatefulWidget {
  static const String id = '/adminaddproduct';
  @override _AdminAddProductState createState() => _AdminAddProductState();}

class _AdminAddProductState extends State<AdminAddProduct> {
  final scaffoldKeyUnique = GlobalKey<ScaffoldState>();


  List taxTypesList = ['IVA', 'Impoconsumo', 'Exento'];
  String? selectedCategory;
  String? selectedTaxType ='IVA';
  final _formKeyAddProduct = GlobalKey<FormState>();
  String? categoryvalue;
  String messageCategory = '';
  bool loading = true;
  bool done = false;


  ProductsAndCategories? productsAndCategories;
  File? imageFile;





  bool iSLoading = false;
  bool startLogingOut = true;



  bool go = false;
  double valorImpuesto = 0;
  double valorDescuento = 0;
  double porcientoDescuento = 0;
  double precioSinImpuesto = 0;
  String message = '';
  void calculatevalues() {
    if (double.tryParse(controllerPorcientoDeImpuesto.text) == null ||
        double.tryParse(controllerPrecio.text) == null ||
        double.tryParse(controllerPrecioAntes.text) == null) {
      UsedWidgets().showNotificationDialogue(context,
          'Por favor, verifique si los valores numerales que ha ingresado son válidos');
      setState(() {go = false;});
    }
    else {
      valorImpuesto = AdminFunctions().valorImpuesto(
          porciento_impuesto: double.parse(controllerPorcientoDeImpuesto.text),
          precio_ahora: double.parse(controllerPrecio.text),
          precio_anterior: double.parse(controllerPrecioAntes.text));
      precioSinImpuesto = AdminFunctions().precioSinImpuesto(
        porciento_impuesto: double.parse(controllerPorcientoDeImpuesto.text),
        precio_ahora: double.parse(controllerPrecio.text),
        precio_anterior: double.parse(controllerPrecioAntes.text),);
      valorDescuento = AdminFunctions().valorDescuento(
        porciento_impuesto: double.parse(controllerPorcientoDeImpuesto.text),
        precio_ahora: double.parse(controllerPrecio.text),
        precio_anterior: double.parse(controllerPrecioAntes.text),
      );
      porcientoDescuento = AdminFunctions().porcientoDescuento(
        porciento_impuesto: double.parse(controllerPorcientoDeImpuesto.text),
        precio_ahora: double.parse(controllerPrecio.text),
        precio_anterior: double.parse(controllerPrecioAntes.text),
      );
      setState(() {go = true;});
    }
  }

  void pickupImage(ImageSource source) async {
    try {
      final imageFile = await ImagePicker().pickImage(source: source);
      if (imageFile == null) return;
      final imageTemporary = File(imageFile.path);
      setState(() {
        this.imageFile = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to pick up the image :$e');
    }
  }


  //Sheet function
  void showPicker(context) {
    showModalBottomSheet(context: context,
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            ListTile(leading: new Icon(Icons.photo_camera_outlined),
              title: new Text('Camera'),
              onTap: () {
                pickupImage(ImageSource.camera);
                Navigator.pop(context);
              },),
            ListTile(leading: new Icon(Icons.photo_library_outlined),
              title: new Text('Galeria'), onTap: () {
                pickupImage(ImageSource.gallery);
                Navigator.pop(context);
              },),
          ],);
        });
  }

  Widget buildImageContainer() {
    return Row(children: [
      Card(child: Stack(
          children: [GestureDetector(onTap: () {showPicker(context);},
              child: Container(decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blueGrey), borderRadius: BorderRadius.circular(10.0)),
                width: MediaQuery.of(context).size.width * 0.60, height: 160,
                child: imageFile != null ? Container(
                  child: Image.file(imageFile!, fit: BoxFit.fill,),)
                    : Container(child: Image.asset(
                    Constants.ASSET_PLACE_HOLDER_IMAGE, fit: BoxFit.fill),),),),
            Positioned(bottom: 0, left: 0,
                child: GestureDetector(onTap: () {setState(() {imageFile = null;});},
                    child: Container(color: Colors.red,
                        child: Icon(Icons.clear, color: Colors.white, size: 40,)))
            )

          ],),
      ),
    ],);
  }


  void newCategoryDialogue(context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text('Anadir una categoria nueva'),
        content: TextField(autofocus: true,
          onChanged: (value) {categoryvalue = value;},),
        actions: [ElevatedButton(onPressed: ()
        async {

          if (categoryvalue != null) {

            setState(() {iSLoading = true;});

             String message12 =await  AddNewcategory().addNewcategory(categoryvalue!);
             // setState(() {categoryvalue==null;});


            Navigator.of(context).pop();
            setState(() {iSLoading =false;});
            UsedWidgets().showNotificationDialogue(context, message12);
          } else {


            UsedWidgets().showNotificationDialogue(context,'El texto es vacio .Intenta de nuevo');

          }



          },
            child: Text('enviar')),




          ElevatedButton(onPressed: () async {


            Navigator.of(context).pop();


          }, child: Text('cancel'))],);});
  }


  //================

  List<Category> categoryList=[];
  //================


  @override
  void initState() {
    AddProductAdminFunction().getProducts().then((value) {
      setState(() {
        categoryList=value;
        done = true;});
    });
    super.initState();
  }

  TextEditingController controllerNombre = TextEditingController(text: '');
  TextEditingController controllerMarca = TextEditingController();
  TextEditingController controllerContenido = TextEditingController();
  TextEditingController controllerTypoImpuesto = TextEditingController();
  TextEditingController controllerPorcientoDeImpuesto = TextEditingController(text: '19');
  TextEditingController controllerPrecio = TextEditingController(text: '0');
  TextEditingController controllerPrecioAntes = TextEditingController(text: '0');
  TextEditingController controllerDescripcion = TextEditingController();


  @override
  void dispose() {
    controllerNombre.dispose();
    controllerMarca.dispose();
    controllerContenido.dispose();
    controllerTypoImpuesto.dispose();
    controllerPorcientoDeImpuesto.dispose();
    controllerPrecio.dispose();
    controllerPrecioAntes.dispose();
    controllerDescripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () async {Navigator.of(context).pop();},
                    icon: Icon(Icons.arrow_back, color: Colors.green,),),
                  IconButton(onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProfileScreen(),
                    ),);},
                    icon: Icon(Icons.account_circle_outlined, color: Colors.green,),),
                  IconButton(onPressed: () async {
                    setState(() {iSLoading = true;});
                    bool answer = await LogoutAdminUserDeliveryMen().logOutAdmin(context);
                    if (answer == true) {Navigator.pushNamed(context, LoginScreen.id);
                      UsedWidgets().showNotificationDialogue(
                          context, 'La sesión ha sido cerrada con éxito.');
                    } else {
                      UsedWidgets().showNotificationDialogue(context, 'Algo salió mal');}
                    setState(() {iSLoading = false;});
                  }, icon: Icon(Icons.exit_to_app, color: Colors.red,),
                  ),],),
            ),


            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Añadir un producto nuevo',style: TextStyle(fontSize: 20),),
                )),
            Divider(thickness: 2,color: Colors.blueGrey,),

            done == false || iSLoading == true ? SpinKitWave(color: Colors.green, size: 50.0,) :
            Expanded(
              child: Column(

                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [buildImageContainer(),],
                  ),
                  Expanded(
                    child: Form(key: _formKeyAddProduct,
                      child: Padding(padding: const EdgeInsets.all(8.0),
                        child: ListView(children: [SizedBox(height: 20,),
                            UsedWidgets().buildDropDownButtonApiList(label: 'Escoger una categoria', valueParam: selectedCategory,
                                onChanged: (value) {setState(() {selectedCategory = value!;});}, list: categoryList),
                            SizedBox(height: 20,),







                            SizedBox(height: 20,),

                            UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Nombre completo', textEditingController: controllerNombre),
                            SizedBox(height: 20,),
                            UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Marca', textEditingController: controllerMarca),
                            SizedBox(height: 20,),
                            UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Contenido', textEditingController: controllerContenido),
                            SizedBox(height: 20,),
                            UsedWidgets().buildDropDownButtonFixedList(
                                label: 'Escoger el impuesto ', onChanged: (value) {selectedTaxType = value!;},
                                list: taxTypesList, valueInitial: 'IVA'),
                            SizedBox(height: 20,),
                            UsedWidgets().doubleValidation(label: 'Porciento de impuesto ',
                                textEditingController: controllerPorcientoDeImpuesto),
                            SizedBox(height: 20,),
                            UsedWidgets().doubleValidation(label: 'Precio ', textEditingController: controllerPrecio),
                            SizedBox(height: 20,),
                            UsedWidgets().doubleValidation(label: 'Precio Antes ', textEditingController: controllerPrecioAntes),
                            SizedBox(height: 20,),
                            UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Descripcion', textEditingController: controllerDescripcion,),
                            SizedBox(height: 20,),
                            Padding(padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKeyAddProduct.currentState!.validate()) {
                                    _formKeyAddProduct.currentState!.save();
                                    calculatevalues();
                                    if (imageFile != null && go == true) {
                                      setState(() {iSLoading = true;});
                                      message = await AddProductAdminFunction().uploadANewProductWithAnImage(
                                        imageFile!,
                                        categoria_id: selectedCategory == null ? '' : selectedCategory!,
                                        nombre_producto: controllerNombre.text.isEmpty ? '' :
                                        controllerNombre.text[0].toUpperCase() + controllerNombre.text.substring(1),
                                        marca: controllerMarca.text.isEmpty ? ''
                                            : controllerMarca.text[0].toUpperCase() + controllerMarca.text.substring(1),
                                        contenido: controllerContenido.text,
                                        typo_impuesto: selectedTaxType == null ? '' : selectedTaxType!,
                                        porciento_impuesto: controllerPorcientoDeImpuesto.text,
                                        valor_impuesto: valorImpuesto.toString(),
                                        precio_ahora: controllerPrecio.text,
                                        precio_sin_impuesto: precioSinImpuesto.toString(),
                                        precio_anterior: controllerPrecioAntes.text,
                                        porciento_de_descuento: porcientoDescuento.toString(),
                                        valor_descuento: valorDescuento.toString(),
                                        descripcion: controllerDescripcion.text.isEmpty ? '' :
                                        controllerDescripcion.text[0].toUpperCase() + controllerDescripcion.text.substring(1),);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(AdminAddProduct.id);
                                      setState(() {iSLoading = false;});
                                      UsedWidgets().showNotificationDialogue(context, message);
                                    }
                                    else if (imageFile == null && go == true) {
                                      setState(() {iSLoading = true;});
                                      message = await AddProductAdminFunction().uploadANewProductWithoutImage(

                                        categoria_id: selectedCategory == null ? '' : selectedCategory!,
                                        nombre_producto: controllerNombre.text.isEmpty ? '' :
                                        controllerNombre.text[0].toUpperCase() + controllerNombre.text.substring(1),
                                        marca: controllerMarca.text.isEmpty ? '' :
                                        controllerMarca.text[0].toUpperCase() + controllerMarca.text.substring(1),
                                        contenido: controllerContenido.text,
                                        typo_impuesto: selectedTaxType == null ? '' : selectedTaxType!,
                                        porciento_impuesto: controllerPorcientoDeImpuesto.text,
                                        valor_impuesto: valorImpuesto.toString(),
                                        precio_ahora: controllerPrecio.text,
                                        precio_sin_impuesto: precioSinImpuesto.toString(),
                                        precio_anterior: controllerPrecioAntes.text,
                                        porciento_de_descuento: porcientoDescuento.toString(),
                                        valor_descuento: valorDescuento.toString(),
                                        descripcion: controllerDescripcion.text.isEmpty ? '' :
                                        controllerDescripcion.text[0].toUpperCase() + controllerDescripcion.text.substring(1),);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(AdminAddProduct.id);
                                      setState(() {iSLoading = false;});
                                      UsedWidgets().showNotificationDialogue(
                                          context, message);
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


          ],
        ),
      ),
    );
  }


}