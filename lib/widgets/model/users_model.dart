
class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final String phonenumber;
  final String address;
  final String profile;

  UserModel({
    this.firstname,
    this.lastname,
    this.email,
    this.phonenumber,
    this.address,
    this.profile
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstname: json['firstname'] ?? "",
      lastname: json['lastname' ?? ""],
      email: json['email' ?? ""],
      phonenumber: json['phonenumber' ?? ""],
      address: json['address' ?? ""],
      profile: json['profile' ?? ""]
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'firstname': firstname  ?? "",
      'lastname': lastname ?? "",
      'email': email ?? "",
      'phonenumber': phonenumber ?? "",
      'address': address ?? "",
      'profile': profile ?? ""
    };
  }
}