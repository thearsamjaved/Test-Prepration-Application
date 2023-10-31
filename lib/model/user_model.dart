class UserModel {
  String? id;
  String? email;
  String? forceType;
  String? name;
  int? progress;
  UserModel({
    required this.id,
    required this.email,
    required this.forceType,
    required this.progress,
    required this.name,
  });
  toJson() {
    return {
      'id': id,
      'forceType': forceType,
      'progress': progress,
      'name': name,
    };
  }
}
