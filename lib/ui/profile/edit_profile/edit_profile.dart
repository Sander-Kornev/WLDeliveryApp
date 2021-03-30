
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile_cubit.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile_state.dart';

class EditProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final EditProfileCubit userCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Edit Profile'),
        actions: [
          TextButton(
            child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 16),),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: userCubit.updateProfileAction,)
        ],
      ),
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Textform(
            key: Key("value"),
          ),
        ),
      ),
    );
  }
}

class Textform extends StatelessWidget {
  const Textform({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditProfileCubit userCubit = BlocProvider.of(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                  String? emailErr = state.emailValidationError;
                  String? usernameErr = state.usernameValidationError;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: userCubit.username,
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
                        initialValue: userCubit.email,
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
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}