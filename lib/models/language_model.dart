class LanguageModel {
  String name;
  String lastMessage;

  LanguageModel({
    required this.name,
    this.lastMessage = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      name: map['name'].toString(),
    );
  }
}