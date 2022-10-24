import 'package:untitled/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled/modules/done_tasks/done_tasks_screen.dart';
import 'package:untitled/shared/componants/componants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/componants/constants.dart';

class HomeLayOut extends StatefulWidget {
  @override
  State<HomeLayOut> createState() => _HomeLayOutState();
}

class _HomeLayOutState extends State<HomeLayOut> {
  int currentIndex = 0;
  List<Widget> screens =[
    NewTasksScreen(),
    ArchivedTasksScreen(),
    DoneTasksScreen(),
  ];
  List <String> titles = [
    'New Tasks',
    'Archived Tasks',
    'Done Tasks',
  ];
    late Database database;
    var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool isbottomsheetshown=false;
    IconData fabIcon = Icons.edit;
     var titlecontroller = TextEditingController();
     var timecontroller = TextEditingController();
     var dateontroller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex]
        ),
      ),
      body: ConditionalBuilder(
        condition: tasks.length>0,
        builder: (context)=> screens[currentIndex],
        fallback: (context)=>Center(child: CircularProgressIndicator()),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(isbottomsheetshown){
            if(formkey.currentState!.validate()){
              insertToDataBase(
                title: titlecontroller.text,
                date: dateontroller.text,
                time: timecontroller.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) =>
                {        Navigator.pop(context),
                  setState((){

                    isbottomsheetshown=false;
                      fabIcon = Icons.edit;
                    tasks=value;
                  }),
                });
              });
            }

          } else{
            scaffoldkey.currentState!.showBottomSheet(
                  (context) => Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            defaultFormField(
                              controller: titlecontroller,
                                type: TextInputType.text,
                                validate: (value){
                                if (value!.isEmpty){
                                  return 'title must not be empty';
                                }
                                return null;
                                },
                                label: 'Task Title',
                                prefix: Icons.title,
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: timecontroller,
                            type: TextInputType.datetime,
                            onTap: (){
                             showTimePicker(
                               context: context,
                               initialTime: TimeOfDay.now(),
                             ).then((value) {
                               timecontroller.text=value!.format(context).toString();
                               print(value!.format(context));
                             });
                            },
                            validate: (value){
                              if (value!.isEmpty){
                                return 'time must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Time',
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: dateontroller,
                            type: TextInputType.datetime,
                            onTap: (){
                              showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-12-30'),
                                ).then((value) =>
                              {

                                dateontroller.text=DateFormat.yMMMd().format(value!)
                              });
                            },
                            validate: (value){
                              if (value!.isEmpty){
                                return 'date must not be empty';
                              }
                              return null;
                            },
                            label: 'Task date',
                            prefix: Icons.calendar_today ,
                          ),
                        ],
                      ),
                    ),
                  ),
              elevation: 20,
            ).closed.then((value) => {
          //  Navigator.pop(context);
                isbottomsheetshown=false,
                setState(() {
              fabIcon=Icons.edit;
            }),

            });
            isbottomsheetshown = true;
            setState(() {
              fabIcon= Icons.add;
            });

          }

        } ,
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          currentIndex:currentIndex ,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
          print(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),

        ],
      ),
    );
  }




  void createDataBase()async{

   database= await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database, version){
        print('database is created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
          print('table created');
        }).catchError((error){
          print('error when Creating table ${error.toString()}');
        });
    },
    onOpen: (database){

      print('database is opened');
    },
  );
  }
  Future insertToDataBase({
    required String title,
    required String time,
    required String date,
  })async{
     return await database.transaction((txn) async
      {
        txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")'
        )
            .then((value) {
           print('$value inserted');
        } ).catchError((error){
          print('error when Inserting new record ${error.toString()}');
        });
        return null;

      });

  }

  Future< List<Map>> getDataFromDatabase(database)async{
   return await database.rawQuery('SELECT * FROM tasks');


  }






}
