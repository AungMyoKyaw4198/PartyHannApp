import 'package:flutter/material.dart';

getInputStyle(String text){
    return InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 10,
            style: BorderStyle.solid,
          ),
        ),
        filled: true,
        hintStyle:
            new TextStyle(color: Colors.grey[800]),
        hintText: text,
        focusColor: Color(0xee7dc778),
        focusedBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    );
  }

getButtonStyle(Color color){
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(color),
    padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 15)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      
    )); 
  }

getCreateButtonStyle(Color color){
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(color),
    padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 15)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      
    )); 
  }

