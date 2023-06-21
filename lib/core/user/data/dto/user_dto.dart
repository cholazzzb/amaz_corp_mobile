class UserDTO {
  UserDTO({
    this.username,
    this.password,
  });

  String? username;
  String? password;

  factory UserDTO.fromJSON(Map<String, dynamic> json) => UserDTO(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJSON() => {"username": username, "password": password};
}
