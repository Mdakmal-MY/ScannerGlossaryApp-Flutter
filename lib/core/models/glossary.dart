import 'package:ocrglossary/core/models/user.dart';

class Glossary{
  String id;
  String word;
  String term;
  String uid;
  Glossary({this.id, this.word, this.term, this.uid});

  Glossary.fromMap(Map data, String id):
    id = id ?? '',
    word = data['word'] ?? '',
    term = data['term'] ?? '',
    uid = data['uid'] ?? '';

  toJson(){
    return{
      "word": word,
      "term": term,
      "uid": uid,
    };
  }
}