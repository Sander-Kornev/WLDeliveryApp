import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
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
    final delegate = Get.find<AppRouterDelegate>();
    return BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: Scaffold(
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
                    delegate: delegate,
                    key: Key("value"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void saveLoginState() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool(LoggedInKey, true);
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    required Key key,
    required GlobalKey<FormState> formKey,
    required this.delegate,
  })   : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final AppRouterDelegate delegate;

  @override
  Widget build(BuildContext context) {
    final LoginCubit userCubit = BlocProvider.of<LoginCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: Colors.white,
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

                      String? emailErr;
                      String? passErr;

                      if (state is LoginValidationError) {
                        emailErr = state.emailValidationError;
                        passErr = state.passwordValidationError;
                      }
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
                            onPressed: () {},
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
                            delegate: delegate,
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
                      onPressed: () => delegate.push(CreateAccountPageConfig),
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
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      onPressed: () => delegate.push(CreateAccountPageConfig),
                      child: const Text(
                        'Sign in with Apple',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
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
    required this.delegate,
  }) : super(key: key);

  final AppRouterDelegate delegate;

  @override
  Widget build(BuildContext context) {
    final LoginCubit userCubit = BlocProvider.of<LoginCubit>(context);
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
            onPressed: () => delegate.push(CreateAccountPageConfig),
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
            //delegate.push(CreateAccountPageConfig),
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
