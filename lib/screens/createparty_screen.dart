import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/services/database.dart';
import 'package:partyhann_app/widgets/screen_widgets/createpaty_widgets.dart';

class CreatePartyScreen extends StatefulWidget {
  const CreatePartyScreen();

  @override
  _CreatePartyScreenState createState() => _CreatePartyScreenState();
}

class _CreatePartyScreenState extends State<CreatePartyScreen> {
  //Intialize services
  final _formKey = GlobalKey<FormState>();
  final DataBaseService dataBaseService = DataBaseService();

  TextEditingController _partyName = TextEditingController();
  TextEditingController _participantNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appbar_color,

      appBar: AppBar(
        backgroundColor: Colors.white,
         title: Text('Create Party',style: TextStyle(color: Colors.black),),
         iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
                children: <Widget>[
                  Center(
                   child: Text(
                     "Create New Party",
                     style: TextStyle(fontSize: 40,color: Colors.black87,fontWeight: FontWeight.bold),
                   ),
                 ),

                 const SizedBox(height: 50.0),

                 // Input Party Name
                 InputLabelWidget(labelName: 'Name',labelColor: Colors.black),
                 InputTextWidget(keyboardType: TextInputType.name,controller: _partyName,placeholderText: "Name",secureText: false,
                  validator: (val) => val.isEmpty ? "Enter Name": null,
                 ),

                  const SizedBox(height: 30.0),

                  // Input number of participants
                  InputLabelWidget(labelName: 'Number of Participant',labelColor: Colors.black),
                  InputNumberWidget(keyboardType: TextInputType.number,controller: _participantNumber,placeholderText: "Number of Participant",secureText: false,
                    validator: (val) => val.isEmpty ? "Enter Number of Participant": null,
                  ),

                  const SizedBox(height: 50.0),

                  // create party button
                  ButtonWidget(
                   buttonName: 'Create Party',
                   buttonColor: AppColors.primary_red,
                   onPressed: () async {
                      if(_formKey.currentState.validate()){
                        String result = await dataBaseService.addPartyEvent(_partyName.text, int.parse(_participantNumber.text), 0);
                        print(result);
                        if(result.contains('Failed'))createPartyFailedAlert(context); 
                        else createPartySuccessAlert(context,'New Party Created');
                        new Future.delayed(new Duration(seconds: 2), () {
                            Navigator.pop(context); //pop dialog
                        });
                      }
                   },
                 ),

                ],
              ),
            ),
          ),
        ),)
    );
  }
}