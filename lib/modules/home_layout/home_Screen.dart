import 'dart:math';

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/provider/cuibt.dart';
import 'package:football/provider/states.dart';

import '../../style/icon_broken.dart';
import '../../style/compenet.dart';
import '../AddNewNoteScreen/AddNewNote.dart';
import '../Display what you wrote Screen/Display what you wrote.dart';
import '../Search_screen/search_Screen.dart';



class Home_Screen extends StatelessWidget {
  var  scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Note_Cubit,NoteStates>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          floatingActionButton:Padding(
            padding: const EdgeInsets.only(right: 3.0,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 140,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20.0),
                      color: Note_Cubit.get(context).isDark?Color(0xFF2ecc71):Colors.white,
                  ),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: MaterialButton(

                      onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewNote() ,));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add,color: Colors.black,size: 25,),

                          Text(
                            'Create Note',
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) ,

          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon:Note_Cubit.get(context).isDark? Icon(Icons.wb_sunny_rounded):Icon(Icons.nightlight_round),onPressed: (){
                  Note_Cubit.get(context).changeAppMode();
                },),
              ),
            ],
            automaticallyImplyLeading: false,
            title: Text('Note App',style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700
            ),),
          ),
          body: ConditionalBuilderRec(
            condition: Note_Cubit.get(context).newNote.length>0,
            builder:(context)=>SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));

                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 3),
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87.withOpacity(0.05),
                                      spreadRadius: .5,
                                      blurRadius: .5,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  enabled: false,

                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(IconBroken.Search, color: Colors.grey),
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle:
                                      TextStyle(color: Colors.grey, fontSize: 15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2ecc71),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.filter_list_rounded, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(

                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,

                        childAspectRatio: 1/1.1,
                        children:List.generate(Note_Cubit.get(context).newNote.length, (index) =>  BuildItems(Note_Cubit.get(context).newNote[index],context),),
                      ),

                    ),



                  ],
                ),
              ),
            ),
            fallback:(context)=> Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Image(image: AssetImage('assets/images/note11.png'),width: 160,height: 150,),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Your Note is Empty.... ',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
      listener: (context,state){
        if(state is AppInsertDatabaseState){
          Navigator.pop(context);
        }
        if(state is AppDeleteDatabaseState)
        {
          Navigator.pop(context);

        }
      },
    );
  }
  Widget BuildItems(model,context)=> InkWell(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Display(
              id: model['id'],
              note: model['task'],
              title: model['title'],
              date: model['date'],
            ),
          ));

    },
    child: Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Note_Cubit.get(context).isDark?AppStyle.CardColorDark[Random().nextInt(AppStyle.CardColorDark.length)]:AppStyle.CardColorLight[Random().nextInt(AppStyle.CardColorLight.length)],
          borderRadius: BorderRadius.circular(8.0)
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(model['type'],style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),),
            ],
          ),

          SizedBox(height: 10,),
          Container(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${model['title']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(onPressed: (){
                  scaffoldKey.currentState!.showBottomSheet((context) => Container(
                    color:Note_Cubit.get(context).isDark?Colors.black :Colors.grey[200],
                    child: Container(

                      decoration: BoxDecoration(
                        color:Note_Cubit.get(context).isDark?Colors.black12: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft:Radius.circular(60) ,),
                      ),
                      height: 130,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                        child: Column(
                          children:
                          [
                            Container(
                              width: 160,

                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(20.0),
                                color:Note_Cubit.get(context).isDark?Colors.black12: Colors.white,
                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child: IconButton(
                                  highlightColor: Colors.white,
                                  onPressed: () {
                                    Note_Cubit.get(context).deleteDatabase(id: model['id']);
                                  },
                                  icon: Text(
                                    ' Delete',
                                    style: TextStyle(
                                      color:Note_Cubit.get(context).isDark?Colors.white: Colors.black,

                                    ),


                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 160,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(20.0),
                                color:Note_Cubit.get(context).isDark?Colors.black12: Colors.white,
                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child: IconButton(
                                  highlightColor: Colors.white,

                                  onPressed: () {
                                    Navigator.pop(context);

                                  },
                                  icon: Text(
                                    ' Cancel',
                                    style: TextStyle(
                                      color:Note_Cubit.get(context).isDark?Colors.white: Colors.black,

                                    ),

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ));
                }, icon: Icon(Icons.more_horiz,size: 18,))

              ],
            ),
          ),
          SizedBox(height: 5,),
          Text(
            '${model['date']}',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5,),

          Expanded(
            child: Text(
              '${model['task']}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,

              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),


        ],
      ) ,
    ),
  );
}

