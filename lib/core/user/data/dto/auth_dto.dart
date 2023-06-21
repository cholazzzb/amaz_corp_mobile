class AuthDTO {
  AuthDTO({
    this.token,
  });

  String? token;

  factory AuthDTO.fromJSON(Map<String, dynamic> json) => AuthDTO(
        token: json["token"],
      );

  Map<String, dynamic> toJSON() => {"token": token};
}
