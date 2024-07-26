class GeminiSafetySettingModel {
  final String category;
  final String threshold;

  GeminiSafetySettingModel({
    required this.category,
    required this.threshold,
  });

  factory GeminiSafetySettingModel.fromJson(Map<String, dynamic> json) {
    return GeminiSafetySettingModel(
      category: json['category'],
      threshold: json['threshold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'threshold': threshold,
    };
  }
}