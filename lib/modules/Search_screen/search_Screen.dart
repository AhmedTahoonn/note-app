import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/provider/cuibt.dart';
import 'package:football/provider/states.dart';
import '../../style/icon_broken.dart';
import '../Display what you wrote Screen/Display what you wrote.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Note_Cubit, NoteStates>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10, top: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        IconBroken.Arrow___Left_2,
                        color: Note_Cubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            Note_Cubit.get(context).getSearch(title: value);
                          },

                          controller: TextEditingController(),
                          style: TextStyle(
                            color: Note_Cubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(IconBroken.Search, color: Colors.grey),
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(Icons.filter_list_rounded,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ConditionalBuilderRec(
                condition:Note_Cubit.get(context).search.length>0 ,
                builder: (context)=> Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) => searchItem2(
                          Note_Cubit.get(context).search[index], context),
                      itemCount: Note_Cubit.get(context).search.length,
                    ),
                  ),
                ),
                fallback: (context)=>Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Image(image: AssetImage('assets/images/note4.png'),width: 100,height: 90,),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Sorry , No result found !',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
      },
      listener: (context, state) {},
    );
  }

  Widget searchItem(model, context) => InkWell(
        onTap: () {
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
        child: Card(
          child: ListTile(
            title: Text(
              model['title'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              model['task'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w400),

            ),
            trailing: Text(
              model['date'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),

            ),
          ),
        ),
      );
  Widget searchItem2(model, context) => InkWell(
    onTap: () {
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

      child: Card(

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 8),
              child: Text(
                model['title'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic,color: Colors.black),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8),
              child: Text(
                model['task'],
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontWeight: FontWeight.w400,color: Colors.blueGrey,fontStyle: FontStyle.italic),

              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    model['date'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic,color: Colors.grey),

                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    ),
  );

}
