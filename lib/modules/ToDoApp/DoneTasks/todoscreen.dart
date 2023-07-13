import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/todo_cubit/cubit.dart';
import '../../../shared/todo_cubit/states.dart';


class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStatesClass>(
        listener: (context,state){},
        builder: (context,state) {
          var tasks=TodoCubit.get(context).doneTasks;
          return tasksEmptyBuilder(tasks:tasks );
        }
    );}

  }

