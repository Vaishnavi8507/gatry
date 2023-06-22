import 'package:flutter/material.dart';
class Bird extends StatelessWidget {
  final double birdAxis;
  final double birdwidth;
  final double birdheight;
Bird({required this.birdAxis,required this.birdheight,required this.birdwidth});
  @override

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2 *birdAxis +birdheight)/(2-birdheight)),
      child:Image.asset(
      'lib/assets/images/flapbird.jpeg',
        width: MediaQuery.of(context).size.height*birdwidth/2,
        height:MediaQuery.of(context).size.height *3/4 *birdheight/2,
        fit:BoxFit.fill,
      ),
    );
  }
}
