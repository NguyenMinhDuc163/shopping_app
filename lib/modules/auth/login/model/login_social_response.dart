class LoginSocialResponse {
  LoginSocialResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  final String? id;
  final String name;
  final String? email;
  final String phone;
  final String image;
  final String? accessToken;
  final String? refreshToken;

  factory LoginSocialResponse.fromJson(Map<String, dynamic> json){
    return LoginSocialResponse(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };

  @override
  String toString(){
    return "$id, $name, $email, $phone, $image, $accessToken, $refreshToken, ";
  }
}
