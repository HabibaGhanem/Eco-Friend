

class Account{
  String? userID;
  String? username;
  String? email;
  String? carbonFootprint;
  String? gender;
  String? birthdate;
  int? age;
  //list of habits
  //list of int carbon footprint
  //current carbonfootprint details object

  Account({this.userID, this.username, this.email, this.carbonFootprint="",
    this.gender,this.birthdate,this.age:0});

  Account.fromJson(Map<String, dynamic> json){
    userID = json['userID'];
    username= json['username'];
    email=json['email'];
    carbonFootprint=json['carbonFootprint'];
    gender=json['gender'];
    birthdate=json['birthdate'];
    age=json['age'];
  }

  Map<String, dynamic> toMap()
  {
    Map<String, dynamic> map={
      'userID':this.userID,
      'username':this.username,
      'email':this.email,
      'carbonFootprint':this.carbonFootprint,
      'gender':this.gender,
      'birthdate':this.birthdate,
      'age':this.age,
    };
    return map;
  }
}