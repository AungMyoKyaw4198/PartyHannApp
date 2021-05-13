import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/services/auth.dart';
import 'package:partyhann_app/widgets/user_widgets/login_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Initialize Services
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool checked = false;
  bool checkBoxError = false;  
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_blue,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: AppColors.primary_blue,
      ),
       body: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),

        // Register form card
         child: Card(
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
           child: Form(
             key: _formKey,
             child: ListView(
               shrinkWrap: true,
               padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
               children: <Widget>[

                 // Tittle
                 Center(
                   child: Text(
                     "Create Account",
                     style: TextStyle(fontSize: 40,color: Colors.black87,fontWeight: FontWeight.bold),
                   ),
                 ),

                 const SizedBox(height: 50.0),

                 //Email Input
                 InputLabelWidget(labelName: 'Email',labelColor: Colors.black),
                 InputTextWidget(keyboardType: TextInputType.emailAddress,controller: _email,placeholderText: "Email Address",secureText: false,
                    validator: (val) => val.isEmpty || !val.contains("@") || !val.contains(".")? "enter a valid eamil": null,
                 ),

                 const SizedBox(height: 10.0),

                 //Password input
                 InputLabelWidget(labelName: 'Password',labelColor: Colors.black),
                 InputTextWidget(keyboardType: TextInputType.emailAddress,controller: _password,placeholderText: "Password",secureText: true,
                  validator: (val) => val.isEmpty ? "Enter Password": null,
                 ),

                 //confirm password input
                 InputLabelWidget(labelName: 'Confirm Password',labelColor: Colors.black),
                 InputTextWidget(keyboardType: TextInputType.emailAddress,controller: _confirmPassword,placeholderText: "Password",secureText: true,
                  validator: (val) {
                    if(val.isEmpty)return 'Enter Password';
                    if(val != _password.text)return 'Password Do Not Match';
                    return null;
                  } 
                 ),

                 const SizedBox(height: 10.0),

                 // check box for terms & confitions
                 Row(
                   children: <Widget>[
                     Checkbox(  
                           value: this.checked,  
                           onChanged: (bool value) {  
                             setState(() {  
                               this.checked = value;
                               checkBoxError = false;  
                             });  
                           },  
                         ),
                     Expanded(
                       flex: 2,
                       child: Text("I accept the terms and conditions about usage",style: Theme.of(context).textTheme.bodyText1,overflow: TextOverflow.clip,)
                     ),
                   ],
                 ),
                
                 // if checkbox in unchecked after form submitted
                 checkBoxError? 
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal:20.0),
                   child: Text('Please check the terms and conditions',style: TextStyle(color: Colors.red,fontSize: 13),),
                 ) : SizedBox.shrink(),

                 const SizedBox(height: 20.0),

                 // Register Button
                 ButtonWidget(
                   buttonName: 'Register',
                   buttonColor: Color(0xeefa726a),
                   onPressed: () async {
                     if(checked){
                       if(_formKey.currentState.validate()){
                         loginLoadingDialog(context);
                         dynamic result = await _auth.registerWithEmailAndPassword(_email.text, _password.text);
                         if(result is String){
                          loginAlertDialogBox(context,result);
                         }else{
                          registerSuccessDialogBox(context,'New User Added');
                          new Future.delayed(new Duration(seconds: 2), () {
                            Navigator.pop(context); 
                          });
                         }
                       }
                     }else{
                       setState(() {
                        checkBoxError = true;
                       });
                     }
                     
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