import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function ,
  required String text,
})=>Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(
     text.toUpperCase() ,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClicable = true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled:isClicable ,
  onFieldSubmitted: onSubmit,
  onChanged:onChange ,
  onTap:onTap ,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,

    ),
    suffixIcon: suffix!=null? IconButton(
      onPressed:suffixPressed,
      icon: Icon(
        suffix,
      ),
    ): null,
    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model) => Padding(
padding: const EdgeInsets.all(20.0),
child: Row(
children: [
CircleAvatar(
radius: 40,
child: Text(
'${model['time']}',
),
),
SizedBox(
width: 20,),
Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
  '${model['title']}',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
Text(
  '${model['date']}',
style: TextStyle(
color: Colors.grey,
),
),
],
),

],
),
);
