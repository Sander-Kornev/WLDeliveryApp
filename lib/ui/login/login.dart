import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final delegate = Get.find<AppRouterDelegate>();
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "images/apple_logo.png",
              width: 100,
              height: 100,
              color: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Welcome 2 Delivery App",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Padding(
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
                        data: ElevatedButtonThemeData(style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(10, 50)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText: 'Email'),
                                    controller: emailTextController),
                                TextFormField(
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText: 'Password'),
                                    controller: passwordTextController),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4.0),
                                                  side: BorderSide(
                                                      color: Colors.red
                                                  ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () =>
                                              delegate.push(CreateAccountPageConfig),
                                          child: const Text(
                                            'SIGNUP',
                                            style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
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
                                                side: BorderSide(
                                                    color: Colors.red
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () =>
                                              delegate.push(CreateAccountPageConfig),
                                          child: const Text(
                                            'LOGIN',
                                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Text("- OR -",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400)
                            ),
                            SizedBox(height: 30,),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                              onPressed: () =>
                                  delegate.push(CreateAccountPageConfig),
                              child: const Text(
                                'Continue with Facebook',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: 10,),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                              onPressed: () =>
                                  delegate.push(CreateAccountPageConfig),
                              child: const Text(
                                'Sign in with Apple',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveLoginState() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool(LoggedInKey, true);
  }
}
