import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/screens/user_screens/register.dart';
import 'package:partyhann_app/services/auth.dart';
import 'package:partyhann_app/widgets/user_widgets/login_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Initialize Services
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_red,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.primary_red,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
              children: <Widget>[

                // logo image
                Container(
                  height: MediaQuery.of(context).size.height /2.5 ,
                  child: Image.asset(
                          ImageAssets.logo,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),

                // Email Input field
                InputLabelWidget(labelName: 'Email',labelColor: Colors.white),
                InputTextWidget(keyboardType: TextInputType.emailAddress,controller: _email,placeholderText: "Email Address",secureText: false,
                  validator: (val) => val.isEmpty || !val.contains("@") || !val.contains(".")? "enter a valid eamil": null,
                ),

                const SizedBox(height: 10.0),

                // Password Input field
                InputLabelWidget(labelName: 'Password',labelColor: Colors.white),
                InputTextWidget(keyboardType: TextInputType.emailAddress,controller: _password,placeholderText: "Password",secureText: true,
                  validator: (val) => val.isEmpty ? "Enter Password": null,
                ),

                const SizedBox(height: 30.0),

                 // Login Button
                ButtonWidget(
                buttonName: 'Login',
                  buttonColor: AppColors.primary_green,
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      loginLoadingDialog(context);
                      dynamic result = await _auth.signInWithEmailAndPassword(_email.text, _password.text);
                      if(result is String){
                        new Future.delayed(new Duration(seconds: 2), () {
                            loginAlertDialogBox(context,result);
                        });
                        
                      }else{
                        new Future.delayed(new Duration(seconds: 2), () {
                            Navigator.pushReplacementNamed(context, '/view');
                        });
                      }
                    }
                  },
                ),

                const SizedBox(height: 20.0),

                // Create Account Button
                ButtonWidget(
                  buttonName: 'Create Account',
                  buttonColor: AppColors.primary_blue,
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen(),));
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
