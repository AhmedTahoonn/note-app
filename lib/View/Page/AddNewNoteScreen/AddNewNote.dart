import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../Constant/style/icon_broken.dart';
import '../../../View_Model/Bloc/cuibt.dart';
import '../../../View_Model/Bloc/states.dart';


class Item
{
  final String name;
  final Icon icon;
  Item(this.name,this.icon,);

}
class AddNewNote extends StatefulWidget {
  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  var titleController=TextEditingController();
  var noteController=TextEditingController();
 var dateController=TextEditingController();
 var selected="Uncategorized";
 List<Item>type=
 [
   Item("Uncategorized", Icon(Icons.circle,color:Colors.red ,size: 12,)),
   Item("Work", Icon(Icons.work,color: Colors.green,size: 14), ),
   Item("Personal", Icon(Icons.person,color: Colors.amber,size: 14), ),
   Item("Family affair", Icon(Icons.family_restroom_outlined,color: Colors.orange,size: 14), ),
   Item("Study", Icon(Icons.school_outlined,color: Colors.indigo,size: 14),),

 ];



 @override
  Widget build(BuildContext context) {
   dateController.text=DateFormat.yMMMMd().format(DateTime.now());

    return BlocConsumer<Note_Cubit,NoteStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Note',

              ),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2,),
              ),
              actions: [
                Note_Cubit.get(context).done?IconButton(onPressed: (){

                 Note_Cubit.get(context).insertDatabase(title:titleController.text, task: noteController.text, date: dateController.text,type: selected);
                 Note_Cubit.get(context).done=false;


                }, icon: Icon(Icons.done,color: Colors.green,))

                :Container(
                 color: Colors.black,
               ),

              ],

            ),
            
            body: Column(
              children:
              [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10,left: 10),
                    child: Column(
                      children: [

                        TextFormField(
                          controller: dateController,
                          enabled:false ,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '${DateFormat.yMMMMd().format(DateTime.now())}',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),

                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          onChanged: (value){
                            Note_Cubit.get(context).changeDone(titleController.text,noteController.text);

                          },
                          controller: titleController,
                          style:Theme.of(context).textTheme.bodyText1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                            ),

                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLines:null,
                            style:Theme.of(context).textTheme.bodyText1,
                            controller: noteController,
                            onChanged: (value){
                              Note_Cubit.get(context).changeDone(titleController.text,noteController.text);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Note something down',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15
                              ),

                            ),

                          ),
                        ),
                        Container(
                          color:Note_Cubit.get(context).isDark ?Colors.black:Colors.grey[200],
                          height: 60,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Container(
                                height: .4,
                                width:double.infinity,
                                color: Colors.grey,

                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButton<dynamic>(items:type.map((Item type) => DropdownMenuItem(child:Row(
                                children:
                                [
                                  type.icon,
                                  const SizedBox(width: 10,),
                                  Text(type.name,style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey
                                  ),)
                                ],
                              ),value: type.name,)).toList(), onChanged:(val){
                                setState(() {
                                  selected=val;
                                  // print(selected);
                                });
                              },value: selected,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
