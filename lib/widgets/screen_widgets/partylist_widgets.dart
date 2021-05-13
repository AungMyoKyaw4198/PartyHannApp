import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/screens/viewparty_screen.dart';
import 'package:partyhann_app/services/auth.dart';

class PartyGridCard extends StatefulWidget {
  final String documentID;
  final String partyName;
  final int currentPartyMember;
  final int totalPartyMember;

  const PartyGridCard({this.documentID,this.partyName,this.currentPartyMember,this.totalPartyMember});

  @override
  _PartyGridCardState createState() => _PartyGridCardState();
}

class _PartyGridCardState extends State<PartyGridCard> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Expanded(
                  flex: 2,
                  child: Image.asset(ImageAssets.partyImage,fit: BoxFit.cover)),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: Text(widget.partyName)),
                Divider(color: Colors.black,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("${widget.currentPartyMember} / ${widget.totalPartyMember}"),
                  
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xee7dc778)),
                      child: Text("Join"),
                      onPressed: () async {
                        int currentMember = widget.currentPartyMember;
                        String userName = await _auth.getUserEmail();
                        if(currentMember != widget.totalPartyMember){
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> ViewPartyScreen(userName: userName,partyName: widget.partyName,totalPartyMember: widget.totalPartyMember,currentPartyMember: currentMember+1,documentID: widget.documentID,)),);
                        } else{
                          alertDialogBox(context);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
  }
}

void alertDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
        title: Text('Party Room is full!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Image.asset(ImageAssets.error,fit: BoxFit.cover),
              Text('This party room has reached its limit. Please try again later'),
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
