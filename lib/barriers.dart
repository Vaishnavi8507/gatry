import 'package:flutter/material.dart';
 class Barrier extends StatelessWidget {
   //final size;
 final   barrierwidth;
 final barrierheight;
 final barrierX;
 final bool isThisBottomBarrier;

 Barrier(
 {
   this.barrierwidth,
   this.barrierheight,
   required this.isThisBottomBarrier,
   this.barrierX,
}
     );

 @override

  Widget build(BuildContext context) {
   return Container(
     alignment: Alignment((2 * barrierX + barrierwidth) / (2 - barrierwidth),
       isThisBottomBarrier ? 1 : -1,
     ),
     child: Container(
       color: Colors.green,
      width: MediaQuery.of(context).size.width * barrierwidth / 2,
       height: MediaQuery.of(context).size.height * 3 / 4 * barrierheight / 2,
     ),
   );
 }
  }

