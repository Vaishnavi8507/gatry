import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gatry/barriers.dart';
import 'package:gatry/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdAxis = 0;
  double time = 0;
  double height = 0;
  double gravity=-4.9;
  double velocity=3.5;
  double birdwidth=0.1;
  double birdheight=0.1;
  double initialHeight = birdAxis;

  bool gameHasStarted = false;

  static List<double>barrierX=[2,2 *1.5];
  static double barrierwidth=0.5;
  List<List<double>>barrierheight=[
    [0.6,0.4],
    [0.4,0.6],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      //time += 0.05;
      height = gravity * time * time + velocity * time;

      setState(() {
        birdAxis = initialHeight - height;
      });

      if(birdIsDead()){
        timer.cancel();
        gameHasStarted=false;
        _showDialog();
      }
      moveMap();

      time += 0.01;
    });
  }
  void moveMap(){
    for(int i=0;i< barrierX.length;i++){
      setState(() {
        barrierX[i] -=0.005;
      });
      if(barrierX[i] < -1.5){
        barrierX[i] +=3;
      }
    }
  }
  void resetGame(){
    Navigator.pop(context);
    setState(() {
    birdAxis=0;
    gameHasStarted=false;
    time=0;
    initialHeight=birdAxis;
    });
  }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            backgroundColor:Colors.green,
            title:Center(
              child:Text("GAME OVER",
              style:TextStyle(
                color:Colors.white,
              ),
              ),
            ),
            actions:[
              GestureDetector(
                onTap:resetGame,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child:Container(
                    padding: EdgeInsets.all(7),
                    color:Colors.white,
                    child:Text(
                      'PLAY AGAIN',
                      style:TextStyle(
                        color:Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          );
        });
  }

  void jump(){
    setState(() {
      time=0;
      initialHeight=birdAxis;
    });
  }

  bool birdIsDead(){
    if (birdAxis < -1 || birdAxis > 1) {
      return true;
    }
    for(int i=0;i< barrierX.length;i++){
      if(barrierX[i] <=barrierwidth &&
          barrierX[i] +barrierwidth >= -birdwidth &&
          (birdAxis <=-1 +barrierheight[1][0] ||
              birdAxis +birdheight >=1- barrierheight[1][1])){
        return true;
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:gameHasStarted? jump:startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.lightBlue,
                child:Center(
                child: Stack(
                  children: [
                    Bird(
                      birdAxis:birdAxis,
                      birdwidth: birdwidth,
                      birdheight: birdheight,
                    ),

                      Barrier(
                        barrierX:barrierX[0],
                        barrierwidth:barrierwidth,
                        barrierheight:barrierheight[0][1],
                        isThisBottomBarrier:false,
                      ),

                    Barrier(
                      barrierX:barrierX[1],
                      barrierwidth:barrierwidth,
                      barrierheight:barrierheight[1][0],
                      isThisBottomBarrier:true,
                    ),
                    Barrier(
                      barrierX:barrierX[1],
                      barrierwidth:barrierwidth,
                      barrierheight:barrierheight[1][0],
                      isThisBottomBarrier:false,
                    ),
                    Barrier(
                      barrierX:barrierX[1],
                      barrierwidth:barrierwidth,
                      barrierheight:barrierheight[1][1],
                      isThisBottomBarrier:true,
                    ),


                    Container(
                      alignment: Alignment(0, -0.2),
                      child:Text( gameHasStarted? ' ': "TAP  TO  PLAY",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
        ),
        Expanded(
              child: Container(
                  color: Colors.green,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SCORE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "BEST",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "10",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ])),

                        ),
                        ],
                      ),
      ),
    );


  }
}
