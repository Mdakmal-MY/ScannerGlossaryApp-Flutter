import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
Map<int, Color> color ={
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};
class LoadingScreen extends StatelessWidget{
  MaterialColor colorCustom = MaterialColor(0xFF272727, color);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: colorCustom,
      child: Center(
        child: SpinKitFoldingCube(
          color: colorCustom,
          size: 150,

        ),
      ),
    );
  }
}