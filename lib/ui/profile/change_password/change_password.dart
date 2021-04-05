
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_password_cubit.dart';
import 'change_password_state.dart';

class ChangePassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ChangePasswordCubit changePassCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Change Password'),
        actions: [
          TextButton(
            child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 16),),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: changePassCubit.changePassword,)
        ],
      ),
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: TextFieldForm(
            key: Key("value"),
          ),
        ),
      ),
    );
  }
}

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    required Key key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChangePasswordCubit userCubit = BlocProvider.of(context);
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
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {

                    String? oldPassErr = state.oldPasswordValidationError;
                    String? newPassErr = state.newPasswordValidationError;
                    String? confirmPassErr = state.confirmPasswordValidationError;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Old Password',
                              errorText: oldPassErr),
                          onChanged: userCubit.setOldPassword,
                        ),
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'New Password',
                              errorText: newPassErr),
                          onChanged: userCubit.setNewPassword,
                        ),
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Confirm New Password',
                              errorText: confirmPassErr),
                          onChanged: userCubit.setConfirmPassword,
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