import 'package:brew_app/models/BrewModel.dart';
import 'package:brew_app/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference collectionRef = Firestore.instance.collection('brew');

  Future updateUserData(String sugars, int strength, String name) async {
    return await collectionRef.document(this.uid).setData({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }


  // brew list from snapshot
  List<BrewModel> _brewsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc)  {
      return BrewModel(
          name: doc.data['name'] ?? '',
          sugars: doc.data['sugars'] ?? '0',
          strength:doc.data['strength'] ?? 0
      );
    }).toList();
  }

  Stream<UserData> get getUserDoc {
    return collectionRef.document(this.uid).snapshots().map((event) {
      return UserData(
        uid: this.uid,
        name: event.data['name'] ?? '',
        sugars: event.data['sugars'] ?? '',
        strength: event.data['strength'] ?? 0,
      );
    });
  }

  Stream<List<BrewModel>> get notifyIfTheresChanged {
    return this.collectionRef.snapshots().map((event) => this._brewsListFromSnapshot(event));
  }

}