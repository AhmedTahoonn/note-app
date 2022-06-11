import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/style/icon_broken.dart';
import 'package:intl/intl.dart';

import '../../provider/cuibt.dart';
import '../../provider/states.dart';


class Display extends StatelessWidget {
final String note;
final int id;
final String title;
final String date;

Display( {
  required this.id,
  required this.note,
  required this.title,
  required this.date,
});
var titleController=TextEditingController();
var noteController=TextEditingController();
var dateController=TextEditingController();
var newDateController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Note_Cubit,NoteStates>(
      listener: (context, state) {
         if(state is AppUpdateDataFromDatabaseState)
           {
             Navigator.pop(context);

           }
      },
      builder: (context, state) {
        noteController.text=note;
        titleController.text=title;
        dateController.text=date;
        newDateController.text=DateFormat.yMMMMd().format(DateTime.now());

        return  SafeArea(
          child: Scaffold(
            backgroundColor: Note_Cubit.get(context).isDark?Colors.black:Colors.white,
            appBar: AppBar(

              title: Text(
                'Note',
                style:Theme.of(context).textTheme.bodyText1,

              ),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2,color: Note_Cubit.get(context).isDark?Colors.white:Colors.black,),
              ),
              actions:
              [
                IconButton(onPressed: (){
                  Note_Cubit.get(context).updateDatabase(  title: titleController.text, id: id,task: noteController.text,date: newDateController.text);

                },
               icon:Icon(Icons.done,color: Colors.green,),
                )
              ],

              backgroundColor: Note_Cubit.get(context).isDark?Colors.black:Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children:
                  [
                    TextFormField(
                      controller: dateController,
                      enabled: false,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                      ),

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 20
                        ),

                      ),
                    ),
                    TextFormField(
                      controller: titleController,
                      style: Theme.of(context).textTheme.bodyText1,

                      onChanged: (value)
                      {

                      },
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),

                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.newline,
                      maxLines: 30,

                      style: Theme.of(context).textTheme.bodyText1,

                      controller: noteController,
                      onChanged: (value)
                      {

                      },
                      decoration: InputDecoration(

                        border: InputBorder.none,
                        hintText: 'Note something down',

                        hintStyle: TextStyle(

                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),

                      ),

                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
