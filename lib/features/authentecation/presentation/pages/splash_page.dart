import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theems/color_theme.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/pages/auth_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print('this is state of app');
    print(BlocProvider.of<AuthBloc>(context).state);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/to do.jpeg'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Todo App',
              style: TextStyle(
                fontSize: 40.0,
                color: colorgray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
