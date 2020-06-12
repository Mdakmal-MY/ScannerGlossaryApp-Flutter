import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackApi{

  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  FeedbackApi(this.path){
  ref = _db.collection(path);
  }

  Stream<QuerySnapshot> streamFeedbackCollection(){
  return ref.orderBy("date", descending: true).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id){
  return ref.document(id).get();
  }

  Future<void> removeDocument(String id){
  return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data){
  return ref.add(data);
  }

}