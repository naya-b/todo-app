import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/widgets/loading_widget.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/pages/login_page.dart';
import 'package:todo_app/features/authentecation/presentation/pages/register_page.dart';
import 'package:todo_app/features/authentecation/presentation/pages/splash_page.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/pages/tasks_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
    if (state is LoadingState) {
      return LoadingWidget();
    } else if (state is LoadedStateCheck) {
      if (state.param.check) {
        print('here is email');
        print(state.param.email);
        BlocProvider.of<TasksBloc>(context)
            .add(GetAllTasksEvent()); //email: state.param.email
        return TasksPage();
      } else {
        return LoginPage();
      }
    } else if (state is LoadedStateLogin) {
      if (state.param.check) {
        BlocProvider.of<TasksBloc>(context)
            .add(GetAllTasksEvent()); //email: state.param.email
        return TasksPage();
      } else {
        return LoginPage();
      }
    } else if (state is LoadedStateCreate) {
      if (state.create) {
        return TasksPage();
      } else {
        return RegisterPage();
      }
    }
    // else if (state is LoadedStateLogout) {
    //   return SplashPage();
    // }
    return SplashPage();
  });
}
