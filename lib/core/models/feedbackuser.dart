class FeedbackUser{
  String email;
  String Date;
  String Comment;

  FeedbackUser({this.email, this.Date, this.Comment});

  FeedbackUser.fromMap(Map<String, dynamic> data):
      email = data['email'] ?? '',
      Date = data['date'] ?? '',
      Comment = data['comment'] ?? '';

  Map<String, dynamic> toJson(){
    return{
      "email": email,
      "date": Date,
      "comment": Comment,
    };
  }
}