class UserImage{

  String id;
  String imageLink;

  UserImage({this.id, this.imageLink});

  UserImage.fromMap(Map<String, dynamic> data):
        id = data['id'] ?? '',
        imageLink = data['imageLink'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imageLink": imageLink,
    };
  }
}