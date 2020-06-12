class Bookmarks{
  String id;
  String email;
  String word;
  String term;


  Bookmarks({this.id, this.email, this.word, this.term});

  Bookmarks.fromMap(Map<String, dynamic> data):
        id = data['id'] ?? '',
        email = data['email'] ?? '',
        word = data['word'] ?? '',
        term = data['term'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "word": word,
      "term": term,
    };
  }
}
