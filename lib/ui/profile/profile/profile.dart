import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/ui/profile/profile/profile_cubit.dart';
import 'package:wl_delivery/ui/profile/profile/profile_state.dart';
import 'package:wl_delivery/extensions/optional.dart';



class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = BlocProvider.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('My Profile'),
          actions: [BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return (state is ProfileLoggedInUsualState)
                    ? IconButton(icon: Icon(Icons.edit), onPressed: cubit.edit)
                    : Container();
              })
          ],
        ),
        backgroundColor: Colors.orangeAccent,
        body: SafeArea(
          child: Center(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                CupertinoIcons.person_alt_circle,
                size: 150,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
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
                          offset:
                          Offset(0.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state.isLoggedIn) {
                              return LoggedInCentraInfo(cubit: cubit, state: state,);
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Please login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Spacer(),
                                  TextButton(
                                      onPressed: cubit.login,
                                      child: Text(
                                        "Login or Signup",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )),
                                ],
                              );
                            }
                          }),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        )
    );
  }
}

class LoggedInCentraInfo extends StatelessWidget {
  const LoggedInCentraInfo({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  final ProfileCubit cubit;
  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          (state.user!.fullname).orEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24),
        ),
        SizedBox(
          height: 30,
        ),
        if (state is ProfileLoggedInUsualState)
          ProfileLoggedInUsualWidget(cubit: cubit, state: state as ProfileLoggedInUsualState,),
        if (state is ProfileLoggedInSocialState)
          ProfileLoggedInSocialWidget(state: state as ProfileLoggedInSocialState,),
        Spacer(),
        Center(
          child: TextButton(
              onPressed: cubit.logout,
              child: Text(
                "Logout",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )),
        ),
      ],
    );
  }
}

class ProfileLoggedInSocialWidget extends StatelessWidget {
  const ProfileLoggedInSocialWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ProfileLoggedInSocialState state;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment
            .start,
        children: [
          Text(
            'Signed in with ${state
                .networkName}',
            style: TextStyle(
                color: Colors.black54),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
        ]
    );
  }
}

class ProfileLoggedInUsualWidget extends StatelessWidget {
  const ProfileLoggedInUsualWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  final ProfileCubit cubit;
  final ProfileLoggedInUsualState state;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment
            .start,
        children: [
          Text(
            'Email',
            style: TextStyle(
                color: Colors.black54),
          ),
          Text(
            (state.user.email).orEmpty,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          TextButton(
              style: ButtonStyle(
                  padding:
                  MaterialStateProperty.all(
                      EdgeInsets.zero)),
              onPressed: cubit.changePassword,
              child: Text(
                "Change Password",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )),
        ]
    );
  }
}
