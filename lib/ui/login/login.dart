
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wl_delivery/ui/login/login_cubit.dart';
import 'package:wl_delivery/ui/login/login_state.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Continue as guest",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "images/apple_logo.png",
                width: 100,
                height: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome 2 Delivery App",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              LoginForm(
                formKey: _formKey,
                key: Key("value"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    required Key key,
    required GlobalKey<FormState> formKey,
  })   : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final LoginCubit userCubit = BlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(10, 50)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {

                    String? emailErr = state.emailValidationError;
                    String? passErr = state.passwordValidationError;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                              errorText: emailErr),
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: false,
                          autocorrect: false,
                          onChanged: (value) => userCubit.setEmail(value),
                        ),

                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Password',
                              errorText: passErr),
                          onChanged: (value) => userCubit.setPassword(value),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => userCubit.forgotPassword(),
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.black38, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoginMainButtons(
                          key: Key("value"),
                        ),
                        // ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Text("- OR -",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    onPressed: () => userCubit.fbLogin(),
                    child: const Text(
                      'Continue with Facebook',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (Platform.isIOS)
                    SignInWithAppleButton(
                        onPressed: () => userCubit.signInWithApple()
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginMainButtons extends StatelessWidget {
  const LoginMainButtons({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginCubit userCubit = BlocProvider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
            onPressed: () => userCubit.signup(),
            child: const Text(
              'SIGNUP',
              style: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
            onPressed: () => userCubit.login(),
            child: const Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
