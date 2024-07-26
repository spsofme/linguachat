class GeminiContentModel {
  final String role;
  final List<Map<String,dynamic>> parts;

  GeminiContentModel({
    required this.role,
    required this.parts,
  });

  factory GeminiContentModel.fromJson(Map<String, dynamic> json) {
    return GeminiContentModel(
      role: json['role'],
      parts: List<Map<String,dynamic>>.from(json['parts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'parts': parts,
    };
  }
}