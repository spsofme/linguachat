class GeminiGenerationConfigModel {
  final double temperature;
  final double topK;
  final double topP;
  final int maxOutputTokens;
  final String responseMimeType;

  GeminiGenerationConfigModel({
    required this.temperature,
    required this.topK,
    required this.topP,
    required this.maxOutputTokens,
    required this.responseMimeType,
  });

  factory GeminiGenerationConfigModel.fromJson(Map<String, dynamic> json) {
    return GeminiGenerationConfigModel(
      temperature: json['temperature'],
      topK: json['topK'],
      topP: json['topP'],
      maxOutputTokens: json['maxOutputTokens'],
      responseMimeType: json['responseMimeType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'topK': topK,
      'topP': topP,
      'maxOutputTokens': maxOutputTokens,
      'responseMimeType': responseMimeType,
    };
  }
}