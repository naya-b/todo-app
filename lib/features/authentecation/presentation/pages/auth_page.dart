import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/util/snackbar_message.dart';
import 'package:todo_app/core/widgets/loading_widget.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/pages/login_page.dart';
import 'package:todo_app/features/authentecation/presentation/pages/register_page.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      print('state lister: $state');
      if (state is LoadedStateCreate) {
        if (state.create) {
          Navigator.pushReplacementNamed(context, 'loginpage');
        }
      } else if (state is LoadedStateCheck) {
        if (state.param.check) {
          BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent());
          Navigator.pushReplacementNamed(context, 'taskspage');
        }
      } else if (state is LoadedStateLogin) {
        if (state.param.check) {
          BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent());
          Navigator.pushNamedAndRemoveUntil(
            context,
            'taskspage',
            (Route<dynamic> route) => false,
          );
        }
      } else if (state is ErrorState) {
        SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
      }
    },
    builder: (context, state) {
      print('state builder: $state');
      if (state is LoadingState) {
        return LoadingWidget();
      } else if (state is LoadedStateCheck) {
        if (!state.param.check) {
          print('check false');
          return LoginPage();
        } else {
          //TODO : should disscuss this situation
        }
      } else if (state is LoadedStateLogin) {
        if (!state.param.check) {
          return LoginPage();
        }
      } else if (state is LoadedStateCreate) {
        if (!state.create) {
          return RegisterPage();
        }
      }
      print('return default');
      return LoadingWidget();
    },
  );
}
