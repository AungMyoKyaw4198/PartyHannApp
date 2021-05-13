import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyhann_app/resources/resources.dart';
import 'package:partyhann_app/screens/createparty_screen.dart';
import 'package:partyhann_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyhann_app/services/database.dart';
import 'package:partyhann_app/widgets/screen_widgets/partylist_widgets.dart';

class PartyListScreen extends StatefulWidget {
  const PartyListScreen();

  @override
  _PartyListScreenState createState() => _PartyListScreenState();
}

class _PartyListScreenState extends State<PartyListScreen> {
  // Initialize services
  final AuthService _auth = AuthService();
  final DataBaseService dataBaseService = DataBaseService();

  @override
  Widget build(BuildContext context) {
    CollectionReference parties = FirebaseFirestore.instance.collection('parties');

    return Scaffold(

       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text('All Party',style: TextStyle(color: Colors.black),),
         iconTheme: IconThemeData(
          color: Colors.black,
        ),
         centerTitle: true,
         actions: <Widget>[
           Container(
             padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },),
           ),
         ],
       ),

       body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
         child: StreamBuilder(
           stream: parties.snapshots(),
           builder: (context, snapshot){
             if(!snapshot.hasData) return const Text('Loading');

             // Show party grid view
             return GridView.count(
                    childAspectRatio: (200/300),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    children: List.generate(snapshot.data.docs.length, (index){
                      return Container(
                        child: PartyGridCard(
                          documentID: snapshot.data.docs[index].id.toString(),
                          partyName: snapshot.data.docs[index]['partyname'],
                          currentPartyMember: snapshot.data.docs[index]['current_partymember'],
                          totalPartyMember: snapshot.data.docs[index]['total_partymember'],
                        ),
                      );
                     }
                    ),
                );
           },
         ),
       ),
       
       floatingActionButton: FloatingActionButton(
         child: const Icon(Icons.add),
         backgroundColor: AppColors.primary_red,
         onPressed: (){
           Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePartyScreen(),
                  ));
         },
        ),
    );
  }
}