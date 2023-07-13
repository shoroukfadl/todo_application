import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../styles/colors.dart';
import '../../styles/styles.dart';
import '../todo_cubit/cubit.dart';


Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) => Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (value) {
        onChanged!(value);
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixClicked!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          border: OutlineInputBorder()),
    );

Widget defaultAppBar({
  required BuildContext context,
  String ?title,
  List<Widget>? actions,
})=>AppBar(
  leading: IconButton(
    icon: Icon(IconBroken.Arrow___Left_2),
    onPressed: (){
      Navigator.pop(context);
    },
  ),
  title: Text(
     title!
  ),
  titleSpacing: 5.0,
  actions: actions,
);

Widget buildTasksItems(Map model,context) => Dismissible(
  key: Key(model['id'].toString())  ,
  child:Padding(padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: (){
                  TodoCubit.get(context).updateData(status: 'done', id:model['id'] );
                },
                icon:Icon(Icons.check_box,color: Colors.green,) ),
            IconButton(
                onPressed: (){
                  TodoCubit.get(context).updateData(status: 'archive', id:model['id'] );
                },
                icon:Icon(Icons.archive,color: Colors.black45,) ),
          ],
        ),
      ),
  onDismissed:(direction) {
  TodoCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksEmptyBuilder({required List<Map>tasks})=>ConditionalBuilder(
    condition:tasks.length>0,
    builder: (context)=>ListView.separated(
        itemBuilder: (context,index)=>buildTasksItems(tasks[index],context),
        separatorBuilder: (context,index)=>dividerWidget(),
        itemCount:tasks.length),
    fallback: (context)=>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet Please add Some Tasks',
            style:TextStyle(
                fontSize:16,
                fontWeight: FontWeight.bold) ,)
        ],
      ),
    )
);



Widget dividerWidget()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);

void navigateTo(context,Widget){
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=> Widget
      ));
}

void navigateAndFinish(context,Widget)=>
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>Widget),
          (route) => false);

Widget defaultTextButton({
  required void Function() onTap,
  required String text
})=> TextButton(
        onPressed: (){onTap();},
        child: Text(text.toUpperCase())
    );

void showToast({
  required String text,
  required ToastState state})=>  Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastState{Success,Error,Warning}

Color chooseToastColor(ToastState state){
  Color color;
switch(state){
  case ToastState.Success:
  color=Colors.green;
    break;
    case ToastState.Error:
  color=Colors.red;
    break;
    case ToastState.Warning:
  color=Colors.amber;
    break;
}
return color;
}

