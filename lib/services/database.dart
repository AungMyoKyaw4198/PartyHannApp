import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference collection = FirebaseFirestore.instance.collection('parties');

  //Add Party Event
  Future addPartyEvent(String partyName,int totalPartyMember,int currentPartyMember) async {
    try{
      await collection.add({
        'partyname': partyName, 
        'total_partymember': totalPartyMember, 
        'current_partymember': currentPartyMember 
      });
      return 'New Party Added';
    } catch(error){
      return 'Failed to add new party';
    }
  }

  //Join Party Event
  Future editPartyEvent(String documentID, int currentPartyMember) async {
    await collection.doc(documentID).update({
      'current_partymember' : currentPartyMember
    })
    .then((value) => {})
    .catchError((error) => {});
  }

}