class UserModel {
  String? sId;
  String? email;
  String? dob;
  String? gender;
  String? phoneNumber;
  String? userName;
  String? image;
  String? role;

  UserModel(
      {this.sId,
      this.email,
      this.dob,
      this.gender,
      this.phoneNumber,
      this.userName,
      this.image,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    image = json['image'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['role'] = this.role;
    return data;
  }
}