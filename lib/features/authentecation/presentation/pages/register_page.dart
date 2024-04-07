import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/widgets/register_page/text_form_field_widget.dart';
import 'package:todo_app/features/authentecation/domain/entities/auth.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                    left: 35,
                    right: 35),
                child: Column(
                  children: [
                    TextFormFieldWidgetRegistertPage(
                      showOrHide: false,
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormFieldWidgetRegistertPage(
                      showOrHide: false,
                      hintText: 'Email: example@gmail.com',
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      child: TextFormFieldWidgetRegistertPage(
                        showOrHide: true,
                        hintText: 'Password',
                        controller: passwordController,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                            onPressed: () {
                              Auth auth = Auth(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                              BlocProvider.of<AuthBloc>(context)
                                  .add(CreateUserEvent(
                                auth: auth,
                                // onSuccess: () {
                                //   Navigator.pushReplacementNamed(
                                //       context, 'loginpage');
                                // }
                              ));

                              // context
                              //     .read<AuthBloc>()
                              //     .add(CreateUserEvent(auth: auth));
                            },
                            color: Colors.white,
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          style: ButtonStyle(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
