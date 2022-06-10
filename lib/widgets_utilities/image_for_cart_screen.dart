import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';

class ImagewidgetForCartScreen extends StatelessWidget {
  var networkImageUrl;

  ImagewidgetForCartScreen({Key? key, required this.networkImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return networkImageUrl == null
        ? FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE),
          )
        : FittedBox(
            fit: BoxFit.fill,
            child: ClipRRect(
              child: Image.network(
                  'https://hbtknet.com/storage/notes/$networkImageUrl'),
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
  }
}
