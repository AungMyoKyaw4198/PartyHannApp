import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/services/database.dart';

class ViewPartyScreen extends StatefulWidget {
  @required final String userName;
  @required final String partyName;
  @required final int currentPartyMember;
  @required final int totalPartyMember;
  @required final String documentID;
  const ViewPartyScreen({this.userName,this.partyName,this.currentPartyMember,this.totalPartyMember,this.documentID});

  @override
  _ViewPartyScreenState createState() => _ViewPartyScreenState();
}

class _ViewPartyScreenState extends State<ViewPartyScreen> {
  // initialize services
  final DataBaseService dataBaseService = DataBaseService();
  
  @override
  void initState() { 
    super.initState();
    editPartyEvent(widget.documentID,widget.currentPartyMember);
  }

  editPartyEvent(String documentID,int currentMember) async {
    await dataBaseService.editPartyEvent(documentID, currentMember);
  }
  
  @override
  void dispose() { 
    // Subtract party number when dispose
    editPartyEvent(widget.documentID,widget.currentPartyMember-1);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbar_color,
        iconTheme: IconThemeData(
                color: Colors.black,
              ),
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[

            // Party Image
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: Image.asset(ImageAssets.partyImage,fit: BoxFit.contain),
            ),

            // Party information
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                children: <Widget>[
                  Text(widget.partyName,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)),
                  SizedBox(height: 20,),
                  Text('Current Members : ${widget.currentPartyMember} / ${widget.totalPartyMember}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                ],
              )
            ),

            Divider(color: Colors.black54,),
            
            // Show user information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('* ${widget.userName} joined the party.',style: TextStyle(color: Colors.red,fontStyle: FontStyle.italic,fontSize: 18),),
            ),
            
          ],
        ),
      )
    );
  }
}