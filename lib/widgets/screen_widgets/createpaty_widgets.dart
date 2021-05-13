import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/util/user_page_utils.dart';

class InputTextWidget extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String placeholderText;
  final bool secureText;
  final Function validator;
  const InputTextWidget({this.keyboardType,this.controller,this.placeholderText,this.secureText,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                keyboardType: keyboardType,
                controller: controller,
                obscureText: secureText,
                decoration: getInputStyle(placeholderText),
                validator: validator,
    );
  }
}

class InputNumberWidget extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String placeholderText;
  final bool secureText;
  final Function validator;
  const InputNumberWidget({this.keyboardType,this.controller,this.placeholderText,this.secureText,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                keyboardType: keyboardType,
                controller: controller,
                obscureText: secureText,
                decoration: getInputStyle(placeholderText),
                validator: validator,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}

class InputLabelWidget extends StatelessWidget {
  final String labelName;
  final Color labelColor;
  const InputLabelWidget({this.labelName,this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: Text(
                  labelName,
                  style: TextStyle(fontWeight: FontWeight.bold,color: labelColor,fontSize: 20,),),
              );
  }
}

class ButtonWidget extends StatelessWidget {
  final String buttonName;
  final Function onPressed;
  final Color buttonColor;
  const ButtonWidget({this.buttonName,this.onPressed,this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
                minWidth: 200.0,
                height: 100.0,
                child: OutlinedButton(
                  child: Text(buttonName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,),),
                  style: getCreateButtonStyle(buttonColor),
                  onPressed: onPressed,
                ),
              );
  }
}

void createPartyFailedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
        title: Text('Adding New party failed!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Image.asset(ImageAssets.error,fit: BoxFit.cover),
              Text('Unable to add new party now. Please try again later'),
            ],
            
          )
        ),
        actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
      );
      }
    );
}

void createPartySuccessAlert(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
        title: Image.asset(ImageAssets.error,fit: BoxFit.cover),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(child: Text(message)),
            ],
          )
        ),
      );
      }
    );
    new Future.delayed(new Duration(seconds: 1), () {
        Navigator.pop(context); //pop dialog
    });
}