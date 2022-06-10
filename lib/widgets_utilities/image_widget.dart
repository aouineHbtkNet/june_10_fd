import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';


class ImagewidgetNoButton extends StatelessWidget {
  var networkImageUrl;
   ImagewidgetNoButton({Key? key,
    required this.networkImageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  networkImageUrl ==  null
        ?

    Image.asset(
      Constants.ASSET_PLACE_HOLDER_IMAGE,
      height:200,
      width: double.infinity,
      fit: BoxFit.cover,
    )



        :

    Image.network(
      'https://hbtknet.com/storage/notes/$networkImageUrl',
      height:200,
      width: double.infinity,
      fit: BoxFit.cover,
    );











  }
}
