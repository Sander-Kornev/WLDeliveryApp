
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/ui/signup/signup_cubit.dart';
import 'package:wl_delivery/ui/signup/signup_state.dart';

class Signup extends StatelessWidget {
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Signup'),
      ),
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SignupForm(
            // formKey: _formKey,
            key: Key("value"),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    required Key key,
    // required GlobalKey<FormState> formKey,
  }) : //_formKey = formKey,
        super(key: key);

  // final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final SignupCubit userCubit = BlocProvider.of(context);
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
          // key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(10, 50)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                    String? emailErr = state.emailValidationError;
                    String? passErr = state.passwordValidationError;
                    String? usernameErr = state.usernameValidationError;
                    String? confirmPassErr = state.confirmPasswordValidationError;
                    String? termsErr = state.termsValidationError;
                    bool termsValue = state.termsAndConditionsValue;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Username',
                              errorText: usernameErr),
                          keyboardType: TextInputType.name,
                          enableSuggestions: false,
                          autocorrect: false,
                          onChanged: userCubit.setUsername,
                        ),
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                              errorText: emailErr),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: userCubit.setEmail,
                        ),
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Password',
                              errorText: passErr),
                          onChanged: userCubit.setPassword,
                        ),
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Confirm Password',
                              errorText: confirmPassErr),
                          onChanged: userCubit.setConfirmPassword,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('I accept Terms and Conditions'),
                            Expanded(child: Container()),
                            Switch(value: termsValue, onChanged: userCubit.setTermsValue),
                          ],
                        ),
                        if (termsErr != null)
                          Text(termsErr, style: TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.left,),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () => userCubit.signup(),
                          child: const Text(
                            'CREATE AN ACCOUNT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}