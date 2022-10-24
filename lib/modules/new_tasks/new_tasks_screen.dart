import 'package:flutter/material.dart';

import '../../shared/componants/componants.dart';
import '../../shared/componants/constants.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index)=>buildTaskItem(tasks[index]) ,
      separatorBuilder:(context,index)=> Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ) ,
      itemCount: tasks.length,
    );
  }
}
