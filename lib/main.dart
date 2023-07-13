import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/shared/network/local/cash_helper.dart';
import 'package:todo_application/shared/network/remote/dio_helper.dart';
import 'package:todo_application/shared/todo_cubit/cubit.dart';
import 'package:todo_application/shared/todo_cubit/states.dart';
import 'package:todo_application/styles/Themes.dart';
import 'shared/components/bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CashHelper.init();
 bool ?isDark=CashHelper.getData(key: 'isDark');
 Widget ?widget;


  runApp(MyApp(
      isDark:isDark,
     startWidget:widget ,
  ));
}

class MyApp extends StatelessWidget{
    bool? isDark;
    Widget  ? startWidget;

  MyApp({this.isDark, this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (BuildContext context) => TodoCubit(TodoInitialState())..changeDarkMode(
       fromShared: false
       //!isDark!
      ),
      ),
      ],
      child: BlocConsumer<TodoCubit,TodoStatesClass>
        (listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:TodoCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light ,
            home: startWidget
          );
        },

      ),
    );

  }

}
