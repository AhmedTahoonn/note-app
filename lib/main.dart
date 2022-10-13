import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constant/style/constant.dart';
import 'View/Page/Splash_Screen/Splash_Screen.dart';
import 'View_Model/Bloc/bloc observer.dart';
import 'View_Model/Bloc/cuibt.dart';
import 'View_Model/Bloc/states.dart';
import 'View_Model/network/local/cach.dart';

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
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}


