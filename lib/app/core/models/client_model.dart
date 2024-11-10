class Client {
  final int id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? photo;
  final String? caption;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;

  Client({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.address,
    this.photo,
    this.caption,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      address: json['address'],
      photo: json['photo'],
      caption: json['caption'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'address': address,
      'photo': photo,
      'caption': caption,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
    };
  }
}
