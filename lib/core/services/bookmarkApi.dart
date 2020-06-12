import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkApi{

  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  BookmarkApi(this.path){
    ref = _db.collection(path);
  }

  Stream<QuerySnapshot> streamBookmarkCollection(String id){
    return ref.where("email", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> streamVerifyCollection(String email, String id){
    return ref.where("email" , isEqualTo: email).where("id" , isEqualTo: id).snapshots();
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