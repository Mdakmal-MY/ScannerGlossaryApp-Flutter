class Users {
  String id;
  String firstname;
  String lastname;
  String password;
  String email;
  String role;

  Users({this.id, this.firstname, this.lastname, this.email, this.password, this.role});

  Users.fromMap(Map<String, dynamic> data):
        id = data['id'] ?? '',
        firstname = data['firstname'] ?? '',
        lastname = data['lastname'] ?? '',
        email = data['email'] ?? '',
        password = data['password'] ?? '',
        role = data['role'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
      "role": role,
    };
  }
}
