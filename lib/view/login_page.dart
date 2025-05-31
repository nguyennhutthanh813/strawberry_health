import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/common/widget/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            width: 340,
            height: 345,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 320,
                  width: 340,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.23),
                        blurRadius: 30, // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFieldWidget(
                          icon: Icons.email,
                          hint: 'Enter you email',
                          label: 'Email',
                          inputType: TextInputType.emailAddress),
                      TextFieldWidget(
                        icon: Icons.password,
                        hint: 'Enter you password',
                        label: 'Password',
                        secure: true,
                      ),
                      Row(children: [
                        Expanded(
                            child: Divider(
                              color: Colors.black54,
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("or"),
                        ),
                        Expanded(
                            child: Divider(
                              color: Colors.black54,
                            )),
                      ]),
                      Container(
                        width: 300,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: TextButton(

                            onPressed: () {},
                            child: Text(
                              'Sign in with google',
                              style: TextStyle(color: Colors.black54),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don’t have an Account ? "),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  width: 340,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}