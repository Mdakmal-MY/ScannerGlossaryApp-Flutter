import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ocrglossary/core/models/glossary.dart';
import 'package:ocrglossary/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocrglossary/core/services/processapi.dart';

class CRUDmodel extends ChangeNotifier{
  ProcessApi _processApi = locator<ProcessApi>();
  List<Glossary> glossaryobj;

  Future<List<Glossary>> fetchGlossary() async{
    var result = await _processApi.getDataCollection();
    glossaryobj = result.documents
    .map((doc) => Glossary.fromMap(doc.data, doc.documentID))
    .toList();
    return glossaryobj;
  }

  Stream<QuerySnapshot> fetchGlossaryAsStream(){
    return _processApi.streamDataCollection();
  }

  Stream<QuerySnapshot> searchData(String value){
    return _processApi.streamSearch(value);
  }

  Future<Glossary> getGlossaryById(String id) async{
    var result = await _processApi.getDocumentById(id);
    return Glossary.fromMap(result.data,  result.documentID);
  }

  Future removeGlossary(String id) async{
    var result  =await _processApi.removeDocument(id);
    return result;
  }

  Future updateGlossary(Glossary data, String id) async{
    var result = await _processApi.updateDocument(data.toJson(), id);
    return result;
  }

  Future addGlossary(Glossary data) async{
    var result = await _processApi.addDocument(data.toJson());
    return result;
  }

}