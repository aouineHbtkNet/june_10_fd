import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_functions.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/spalsh_screen_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/top_bar_widget_admins.dart';
import 'admin_profile_screen.dart';
import 'admin_show_products_edit_delet.dart';
import 'package:simo_v_7_0_1/uploadingImagesAndproducts.dart';

import 'login_screen.dart';

class AdminEditProduct extends StatefulWidget {
  static const String id = '/editproduct';
  ProductPaginated?  selectedproduct;
  List<Category> ? categoryList;
  AdminEditProduct({  this.selectedproduct,  this.categoryList});
  @override
  _AdminEditProductState createState() => _AdminEditProductState();
}
class _AdminEditProductState extends State<AdminEditProduct> {
  final scaffoldKeyUnique = GlobalKey<ScaffoldState>();


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























  Widget categoryDropDown(){

    return  DropdownButtonFormField<String>(decoration: InputDecoration(hintText: 'Escoger la categoria',
      label: Text('Categoria', style: TextStyle(fontSize: 20, color: Colors.blue),),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
        value: selectedCategory.toString(),
        onChanged: (value) {setState(() {selectedCategory = value!;});},
        items: widget.categoryList?.map<DropdownMenuItem<String>>((value) =>
            DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.nombre_categoria.toString()))).toList());
  }


//ImagePicker
  File? imageFile;
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera_outlined),
                title: new Text('Camera'),
                onTap: () {
                  pickupImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo_library_outlined),
                title: new Text('Galeria'),
                onTap: () {
                  pickupImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }













bool deleteOriginalFoto=false;
  Widget buildImageContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Card(
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){showPicker(context);},
                child: Container(

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0)),
                width: MediaQuery.of(context).size.width * 0.60,
                    height: 160,


                    child: imageFile != null
                        ? Container(
                      child: Image.file(imageFile!, fit: BoxFit.fill,),
                    )
                        :widget. selectedproduct?.foto_producto != null
                        ? Container(
                      child: deleteOriginalFoto==false?
                      Image.network('https://hbtknet.com/storage/notes/${widget.selectedproduct?.foto_producto}',
                          fit: BoxFit.fill):Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE, fit: BoxFit.fill),
                    )
                        : Container(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE, fit: BoxFit.fill),
                    )
                ),
              ),

              Positioned(bottom: 0, left: 0,
                  child: GestureDetector(onTap: () {setState(() {
                    deleteOriginalFoto=true;
                    imageFile = null;
                  });},
                      child: Container(color: Colors.red,
                          child: Icon(Icons.clear, color: Colors.white, size: 40,)))
              )



            ],

          ),
        ),

    ],);}

  List taxTypesList = ['IVA', 'Impoconsumo', 'Exento'];
  final _formKeyEditpage = GlobalKey<FormState>();
  var selectedCategory;
  int?  productId;
  String? selectedTaxType;

  List<DropdownMenuItem<String>>? emptyList=[];

  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerMarca = TextEditingController();
  TextEditingController controllerContenido = TextEditingController();
  TextEditingController controllerPorcientoDeImpuesto = TextEditingController();
  TextEditingController controllerPrecio = TextEditingController();
  TextEditingController controllerPrecioAntes = TextEditingController();
  TextEditingController controllerDescripcion = TextEditingController();

  @override
  void dispose() {
    controllerNombre.dispose();
    controllerMarca.dispose();
    controllerContenido.dispose();
    controllerPorcientoDeImpuesto.dispose();
    controllerPrecio.dispose();
    controllerPrecioAntes.dispose();
    controllerDescripcion.dispose();
    super.dispose();
  }

  @override
  void initState() {
    productId  = widget.selectedproduct?.id;
    selectedCategory = widget.selectedproduct?.categoria_id ?? selectedCategory;
    controllerNombre.text =widget. selectedproduct?.nombre_producto ?? controllerNombre.text;
    controllerMarca.text = widget.selectedproduct?.marca ?? controllerMarca.text;
    controllerContenido.text =widget. selectedproduct?.contenido ?? controllerContenido.text;
    selectedTaxType = widget.selectedproduct?.typo_impuesto ?? selectedTaxType;
    controllerPorcientoDeImpuesto.text = widget.selectedproduct?.porciento_impuesto.toString() ?? controllerPorcientoDeImpuesto.text;
    controllerPrecio.text = widget.selectedproduct?.precio_ahora.toString() ?? controllerPrecio.text;
    controllerPrecioAntes.text = widget.selectedproduct?.precio_anterior.toString()?? controllerPrecioAntes.text;
    controllerDescripcion.text =widget. selectedproduct?.descripcion ?? controllerDescripcion.text;
    super.initState();
  }


  bool isLoading =false;

  bool startLogingOut=false;
  @override
  Widget build(BuildContext context) {

    print ('id==================${productId}');
    return   Scaffold(
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
                    Navigator.of(context).pop();},
                    icon: Icon(Icons.arrow_back,color: Colors.green,),
                  ),
                  IconButton(onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>AdminProfileScreen (),
                    ),);},

                    icon: Icon(Icons.account_circle_outlined,color: Colors.green,),
                  ),
                  IconButton(onPressed: () async {
                    setState(() {startLogingOut=true;});
                    bool answer= await LogoutAdminUserDeliveryMen().logOutAdmin(context);
                    if(answer==true){
                      Navigator.pushNamed(context, LoginScreen.id);
                      UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                    } else{
                      UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
                    }
                    setState(() {startLogingOut=false;});
                  }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),
                  ),],
              ),

              Divider(thickness: 6,),
              SizedBox(height: 20,),
              Expanded(
                child: Form(
                  key: _formKeyEditpage,
                  child: ListView(
                    children: [


                      Container(child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(' Editar :  ${widget.selectedproduct?.nombre_producto},'
                            ,style:TextStyle(fontSize: 20) ,),
                        ),
                      ),),
                      SizedBox(height: 20,),
                      buildImageContainer(),
                      SizedBox(height: 20,),
                      categoryDropDown(),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Nombre completo', textEditingController: controllerNombre),

                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Marca', textEditingController: controllerMarca),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Contenido', textEditingController: controllerContenido),
                      SizedBox(height: 20,),
                      UsedWidgets().buildDropDownButtonFixedList(valueInitial: selectedTaxType,
                          label: 'Escoger el impuesto ',
                          onChanged: (value) {selectedTaxType = value!;}, list: taxTypesList),
                      SizedBox(height: 20,),
                      UsedWidgets().doubleValidation(label: 'Porciento de impuesto ', textEditingController: controllerPorcientoDeImpuesto),
                      SizedBox(height: 20,),
                      UsedWidgets().doubleValidation(label: 'Precio ', textEditingController: controllerPrecio),
                      SizedBox(height: 20,),
                      UsedWidgets().doubleValidation(label: 'Precio Antes ', textEditingController: controllerPrecioAntes),
                      SizedBox(height: 20,),
                      UsedWidgets().buildTextFormWidgetForTextNoInitial(label: 'Descripcion', textEditingController: controllerDescripcion,),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.teal),
                              padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
                          child:isLoading==true? CircularProgressIndicator() :Text('Enviar'),
                          onPressed: () async {


                            if (_formKeyEditpage.currentState!.validate()) {
                                 _formKeyEditpage.currentState!.save();



                                 print('=========deleteOriginalFoto========================$deleteOriginalFoto');
                                     setState(() {isLoading=true;});
                                    calculatevalues();


                                    if (imageFile!=null && go==true ){

                              String message = await ProductUploadingAndDispalyingFunctions().UpdateWithImage(
                                  imageFile!,
                                  product_id: productId.toString(),
                                  categoria_id:selectedCategory.toString(),
                                  nombre_producto:controllerNombre.text,
                                  marca:controllerMarca.text,
                                  contenido:controllerContenido.text,
                                  typo_impuesto:selectedTaxType??'',
                                  porciento_impuesto:controllerPorcientoDeImpuesto.text,

                                  valor_impuesto: valorImpuesto .toString(),
                                  precio_ahora:controllerPrecio.text,
                                  precio_sin_impuesto:precioSinImpuesto.toString(),
                                  precio_anterior:controllerPrecioAntes.text,
                                  porciento_de_descuento:porcientoDescuento.toString(),
                                  valor_descuento:valorDescuento.toString(),
                                  descripcion:controllerDescripcion.text
                              );


                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                              setState(() {isLoading=false;});
                              UsedWidgets().showNotificationDialogue(context, message);
                            }


                          else  if (imageFile==null
                               &&go==true
                               &&deleteOriginalFoto==false


                           ){


                             String message = await ProductUploadingAndDispalyingFunctions().UpdateWithNoImage(
                               product_id: productId.toString(),
                               categoria_id:selectedCategory.toString(),
                               nombre_producto:controllerNombre.text,
                               marca:controllerMarca.text,
                               contenido:controllerContenido.text,
                               typo_impuesto:selectedTaxType??'',
                               porciento_impuesto:controllerPorcientoDeImpuesto.text,
                               valor_impuesto: valorImpuesto.toString(),
                               precio_ahora:controllerPrecio.text,
                               precio_sin_impuesto:precioSinImpuesto.toString(),
                               precio_anterior:controllerPrecioAntes.text,
                               porciento_de_descuento:porcientoDescuento.toString(),
                               valor_descuento:valorDescuento.toString(),
                               descripcion:controllerDescripcion.text
                           );

                           Navigator.of(context).pop();
                           Navigator.of(context).pop();
                           Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                           setState(() {isLoading=false;});
                           UsedWidgets().showNotificationDialogue(
                               context, message);
                           }


                           else if (
                                imageFile==null
                               && go==true
                               && deleteOriginalFoto==true
                                    &&widget.selectedproduct?.foto_producto==null

                           )
                                    {


                                      String message = await ProductUploadingAndDispalyingFunctions().UpdateWithNoImage(
                                          product_id: productId.toString(),
                                          categoria_id:selectedCategory.toString(),
                                          nombre_producto:controllerNombre.text,
                                          marca:controllerMarca.text,
                                          contenido:controllerContenido.text,
                                          typo_impuesto:selectedTaxType??'',
                                          porciento_impuesto:controllerPorcientoDeImpuesto.text,
                                          valor_impuesto: valorImpuesto.toString(),
                                          precio_ahora:controllerPrecio.text,
                                          precio_sin_impuesto:precioSinImpuesto.toString(),
                                          precio_anterior:controllerPrecioAntes.text,
                                          porciento_de_descuento:porcientoDescuento.toString(),
                                          valor_descuento:valorDescuento.toString(),
                                          descripcion:controllerDescripcion.text
                                      );

                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                                      setState(() {isLoading=false;});
                                      UsedWidgets().showNotificationDialogue(
                                          context, message);
                                    }

                               else      {//delete picture option
                             String message = await ProductUploadingAndDispalyingFunctions().UpdateWithDeletingImgInDB(
                                 product_id: productId.toString(),
                                 categoria_id:selectedCategory.toString(),
                                 nombre_producto:controllerNombre.text,
                                 marca:controllerMarca.text,
                                 contenido:controllerContenido.text,
                                 typo_impuesto:selectedTaxType??'',
                                 porciento_impuesto:controllerPorcientoDeImpuesto.text,
                                 valor_impuesto: valorImpuesto.toString(),
                                 precio_ahora:controllerPrecio.text,
                                 precio_sin_impuesto:precioSinImpuesto.toString(),
                                 precio_anterior:controllerPrecioAntes.text,
                                 porciento_de_descuento:porcientoDescuento.toString(),
                                 valor_descuento:valorDescuento.toString(),
                                 descripcion:controllerDescripcion.text
                             );
                             Navigator.of(context).pop();
                             Navigator.of(context).pop();
                             Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                             setState(() {isLoading=false;});
                             UsedWidgets().showNotificationDialogue(context, message);



                           }


















    }
     }

     ),
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    ),
        ));
  }


}


