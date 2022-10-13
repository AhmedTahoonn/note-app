import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../home_layout/home_Screen.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen:Home_Screen() ,
      backgroundColor: Colors.white,
      duration: 2500,
      splash:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [

          Image(image: AssetImage('assets/images/note7.png'),fit: BoxFit.cover,),
          SizedBox(width: 5,),
          Text('NOTE APP',style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
          ),),
        ],
      ),


    );
  }
}
