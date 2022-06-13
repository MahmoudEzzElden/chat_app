
//unused model
class UserModel {
  List<User> data=[];

  UserModel({required this.data});

  UserModel.fromMap(Map<String, dynamic> map) {
    data = <User>[];
    map['Users'].forEach((v) {
      data.add(User.fromMap(v));
    });
  }
}

class User {
  String? id;
  String? userName;
  String? Age;
  String? Gender;
  String? Url;


  User({this.id, this.userName, this.Age, this.Gender,this.Url});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['User ID'],
        userName: map['User Name'],
        Age: map['Age'],
        Gender: map['Gender'],
        Url:map['ProfilePic']
    );
  }
}
