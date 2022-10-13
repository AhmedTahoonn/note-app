import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/View_Model/Bloc/states.dart';
import 'package:sqflite/sqflite.dart';

import '../network/local/cach.dart';

class Note_Cubit extends Cubit<NoteStates> {
  Note_Cubit() : super(InitialState());
  static Note_Cubit get(context) => BlocProvider.of(context);
  List<Map>newNote= [];
  late Database database;
///////////////////////////////////////////////////////////////////////////////
  /// create database
  void createDatabase() {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,task Text, type TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error when table created${error.toString()}');
          });
        },
        onOpen: (database) {
          getDataFromDatabase(database);
          print(('database opened'));
        }
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  /////////////////////////////////////////////////////////////////////////////
/// insert database
  Future insertDatabase({
    required String title,
    required String task,
    required String date,
    required String type,

  }) async {
    database.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO tasks(title,date,task,type) VALUES("$title","$date","$task","$type")')
          .then((value) {
        if (kDebugMode) {
          print('inserted successfully');
        }
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        if (kDebugMode) {
          print('error when inserted${error.toString()}');
        }
      });
    });
  }
///////////////////////////////////////////////////////////////////////////////
/// get database
  void getDataFromDatabase(database) async
  {
    newNote = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks  ORDER BY date DESC').then((value) {
      newNote=value;
      emit(AppGetDataFromDatabaseState());
      if (kDebugMode) {
        print(value.toString());
      }
    });
  }


  ////////////////////////////////////////////////////////////////////////////////
  /// delete database
  void deleteDatabase({
    required int id,
  })async
  {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id = ?', [id],

    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }
  /////////////////////////////////////////////////////////////////////////////
  /// theme
  bool isDark=true;
  void changeAppMode({sharedPreference})
  {
    if(sharedPreference!=null) {
      isDark = sharedPreference;
      emit(AppModeChangeState());
    }

    else {
      isDark = !isDark;
      CasheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppModeChangeState());

      });
    }
  }
  ////////////////////////////////////////////////////////////////////////////
  /// update database
  void updateDatabase({
    required int id,
    required var title,
    required var task,
    required var date,

  })async
  {
    database.rawUpdate(
      'UPDATE tasks SET title= ?,task=?,date=? WHERE id= ?', [title, task,date,id],

    ).then((value) {
      getDataFromDatabase(database);

      emit(AppUpdateDataFromDatabaseState());
    });

  }
  ////////////////////////////////////////////////////////////////////////////
  /// save note icon
  bool done=false;
  void changeDone(String title,String note)
  {
    if(title.isNotEmpty&&note.isNotEmpty)
    {
      done=true;
      emit(AppDoneSuccessState());
    }
    else
    {
      done=false;
      emit(AppDoneErrorState());

    }

  }
  //////////////////////////////////////////////////////////////////////////////
  /// search in database
  List<Map> search=[];
  void getSearch({
  required String title,
})async
  {
    emit(GetSearchLoadingState());
    search=[];
    database.rawQuery('SELECT id,task,date,title FROM tasks where title=?',[title]).then((value) {
      search=value;

      emit(GetSearchSuccessState());
      if (kDebugMode) {
        print(value.toString());
      }
    });

  }

  ///////////////////////////////////////////////////////////////////////////////
  /// update note icon
  bool updateDone=false;
  void changeDoneUpdate(String title,String note)
  {
    if(title.isNotEmpty)
    {
      updateDone=true;
      emit(AppDoneUpdateSuccessState());
    }
    else
    {
      updateDone=false;
      emit(AppDoneUpdateErrorState());

    }

  }

}
