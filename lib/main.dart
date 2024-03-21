import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/pages/auth_page.dart';
import 'package:todo_app/features/authentecation/presentation/pages/login_page.dart';
import 'package:todo_app/features/authentecation/presentation/pages/register_page.dart';
import 'package:todo_app/features/authentecation/presentation/pages/splash_page.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/add_delete_update_tasks/add_delete_update_tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/pages/tasks_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(TodoApp());
}

// Future initialization(BuildContext? context) async {
//   await Future.delayed(Duration(seconds: 3));
// }

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<AuthBloc>()..add(CheckUserEvent())),
          BlocProvider(create: (_) => di.sl<TasksBloc>()),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdateTasksBloc>()),
          // اذا كان عندي كتير بلوكات الاصح انو اعمل بروفايد للبلوك بالمحل يلي بحتاجه فيه فقط
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'splashpage',
          routes: {
            'splashpage': (context) => SplashPage(),
            'loginpage': (context) => LoginPage(),
            'registerpage': (context) => RegisterPage(),
            'taskspage': (context) => TasksPage(),
            'authpage': (context) => AuthPage(),
          },
        ));
  }
}
