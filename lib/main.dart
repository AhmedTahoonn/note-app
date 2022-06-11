import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/provider/cuibt.dart';
import 'package:football/provider/states.dart';
import 'package:football/network/local/cach.dart';
import 'package:football/style/compenet.dart';
import 'modules/home_layout/home_Screen.dart';
import 'provider/bloc observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  ///shared preference
  await CasheHelper.init();
  var mode=CasheHelper.getBoolean(key: 'isDark');
  runApp( MyApp(mode!));
}

class MyApp extends StatelessWidget {
  final bool mode;
  MyApp(this.mode, {Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Note_Cubit()..createDatabase()..changeAppMode(
        sharedPreference: mode,
      ),
      child: BlocConsumer<Note_Cubit,NoteStates>(
        listener:  (context, state)
        {

        },
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme:AppStyle.dark,
            theme: AppStyle.light,
            themeMode: Note_Cubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: splashScreen(),
          );
        },
      ),
    );
  }
}


