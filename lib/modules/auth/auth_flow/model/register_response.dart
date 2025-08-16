class RegisterResponse {
  RegisterResponse({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.id,
    required this.token,
    required this.refreshToken,
  });

  final dynamic name;
  final String? email;
  final dynamic phone;
  final dynamic image;
  final String? id;
  final String? token;
  final String? refreshToken;

  factory RegisterResponse.fromJson(Map<String, dynamic> json){
    return RegisterResponse(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
      id: json["id"],
      token: json["token"],
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "id": id,
    "token": token,
    "refreshToken": refreshToken,
  };

  @override
  String toString(){
    return "$name, $email, $phone, $image, $id, $token, $refreshToken, ";
  }
}
