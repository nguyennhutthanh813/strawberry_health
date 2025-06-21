import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strawberry_disease_detection/common/widget/text_field.dart';
import 'package:strawberry_disease_detection/common/widget/button.dart';
import 'package:strawberry_disease_detection/view/home_page.dart';
import 'package:strawberry_disease_detection/provider/authentication_provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: 340,
          height: 345,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 324,
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
                        controller: emailController,
                        inputType: TextInputType.emailAddress
                    ),
                    TextFieldWidget(
                      icon: Icons.password,
                      hint: 'Enter you password',
                      label: 'Password',
                      controller: passwordController,
                      secure: true,
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: ButtonWidget(
                        text: Text('Login'),
                        color: Color(0xFF28A745),
                        onPressed: () async {
                          await authProvider.login(emailController.text.trim(), passwordController.text.trim());
                          if (!context.mounted) return;
                          if(authProvider.user == null) {
                            showSignInFailureSnackBar(context: context);
                            return;
                          }
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (route) => false,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
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
            ],
          ),
        ),
      ),
    );
  }


  void showSignInFailureSnackBar({required BuildContext context, String errorMessage = 'Failed to create account'}) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height > 600 ? size.height : 600;
    final verticalRatio = screenHeight/874;
    final horizontalRatio = size.width/402;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12*horizontalRatio),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign-in Failed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16*verticalRatio,
                    ),
                  ),
                  SizedBox(height: 4*verticalRatio),
                  Text(
                    errorMessage,
                    style: TextStyle(fontSize: 14*verticalRatio),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFDC3545),
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 12*horizontalRatio, vertical: 12*verticalRatio),
        action: SnackBarAction(
          label: 'TRY AGAIN',
          textColor: Colors.white,
          onPressed: () {
            // Logic to retry or focus on the form
            // You could also dismiss the SnackBar here if needed
          },
        ),
      ),
    );
  }


}