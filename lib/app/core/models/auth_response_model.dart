class AuthResponseModel {
  final int id;
  final String email;
  final String tokenType;
  final String accessToken;

  AuthResponseModel({
    required this.id,
    required this.email,
    required this.tokenType,
    required this.accessToken,
  });

  // Método para crear una instancia de AuthResponse a partir de un JSON
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      id: json['id'],
      email: json['email'],
      tokenType: json['token_type'],
      accessToken: json['access_token'],
    );
  }

  // Método opcional para convertir una instancia de AuthResponse a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token_type': tokenType,
      'access_token': accessToken,
    };
  }
}
