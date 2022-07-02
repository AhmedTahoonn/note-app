import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../modules/home_layout/home_Screen.dart';
/////////////////////////////////////////////////////////////////////////////
///style
class AppStyle {
  static Color bgColor = Color(0xFFe2eff);
  static Color mainColor = Color(0xFF0063);
  static Color accentColor = Color(0xFF0065FF);
  static List<Color> CardColorLight = [
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.blueGrey.shade100,
  ];
  static List<Color> CardColorDark = [
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.blueGrey.shade100,

    //HexColor('#FF6B6B'),
    //HexColor('#FFD93D'),
    //HexColor('#6BCB77'),
    //HexColor('#4D96FF'),
  ];
  static var light = ThemeData(
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.grey[200],
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[200],
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,

      ),
      backgroundColor: Colors.grey[200],
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueGrey,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      dayPeriodColor: Colors.blueGrey,
      dayPeriodTextColor: Colors.white,
      dialBackgroundColor: Colors.blueGrey,
      dialHandColor: Colors.white60,
      entryModeIconColor: Colors.blueGrey,
      hourMinuteTextColor: Colors.black,
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        side: BorderSide(
            width: 1.5, color: Colors.blueGrey, style: BorderStyle.solid),
      ),
      helpTextStyle: TextStyle(
          color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText2: TextStyle(
        fontSize: 14.0,
        color: Colors.blueGrey,
      ),
    ),
  );
  static var dark = ThemeData(
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.black,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green.shade400,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[300],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyText2: TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        )),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////
/// splash screen
Widget splashScreen()=>AnimatedSplashScreen(
  nextScreen:Home_Screen() ,
  backgroundColor: Colors.white,
  duration: 2500,
  splash:Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

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
