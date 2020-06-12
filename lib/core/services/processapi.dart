import 'package:cloud_firestore/cloud_firestore.dart';

class ProcessApi{
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  ProcessApi(this.path){
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection(){
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection(){
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamSearch(String id){
    return ref.where('word', isGreaterThanOrEqualTo: id).snapshots();
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

  Future<void> updateDocument(Map data, String id){
    return ref.document(id).updateData(data);
  }

  Future<void> bookmarkDocument(Map data, String id, String uid){
    return ref.document(id).updateData(data);
  }
}