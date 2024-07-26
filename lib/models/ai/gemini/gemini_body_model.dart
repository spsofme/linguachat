import 'package:linguachat/models/ai/gemini/gemini_content_model.dart';
import 'package:linguachat/models/ai/gemini/gemini_generation_config_model.dart';
import 'package:linguachat/models/ai/gemini/gemini_safety_setting_model.dart';

class GeminiBodyModel {
  List<GeminiContentModel> contents = [];

  String systemInstructions =
      "Gelen içerikteki mesaja göre arkadaş canlısı bir dil ile cevap ver. Verilen cevap beklenen veri kısmındaki JSON formatında olmalı. JSON içeriğinde yer alan \"message\" anahtarının değeri, gelen içerikteki mesaja verilen cevabı içermeli. \"isBot\" değeri her zaman true olmalı. \"editingMessage\" bölümü ise gelen içerikteki \"content\" anahtarının değeri olan cümlenin, gelen içerikteki \"language\" anahtarının değerinde yer alan dil ile nasıl daha düzgün bir şekilde yazılabileceğini içermeli; bu içerik metini Türkçe dilinde olmalı. \"language\" bölümü ise gelen içerikteki \"language\" bölümü ile aynı olmalı ve verilen cevap burada yer alan dil ile yazılmalı. \"translate\" bölümü ise mesajın beklenen içerikteki yanıtın Türkçe'ye çevrilmiş bir versiyonunu barındırmalı.\ngelen içerik:\n{\n\"message\": string,\n\"language\": string,\n}\nbeklenen veri:\n{\n\"isBot\": boolean\n\"message\": string,\n\"editingMessage\": string\n\"language\": string,\n\"translate\": {\n\"message\": string\n\"language\": string\n}\n}";

  GeminiGenerationConfigModel generationConfig = GeminiGenerationConfigModel(
    temperature: 1,
    topK: 64,
    topP: 0.95,
    maxOutputTokens: 8192,
    responseMimeType: "text/plain",
  );

  List<GeminiSafetySettingModel> safetySettings = [
    GeminiSafetySettingModel(
      category: "HARM_CATEGORY_HARASSMENT",
      threshold: "BLOCK_MEDIUM_AND_ABOVE",
    ),
    GeminiSafetySettingModel(
      category: "HARM_CATEGORY_HATE_SPEECH",
      threshold: "BLOCK_MEDIUM_AND_ABOVE",
    ),
    GeminiSafetySettingModel(
      category: "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      threshold: "BLOCK_MEDIUM_AND_ABOVE",
    ),
    GeminiSafetySettingModel(
      category: "HARM_CATEGORY_DANGEROUS_CONTENT",
      threshold: "BLOCK_MEDIUM_AND_ABOVE",
    ),
  ];

  GeminiBodyModel({
    required this.contents,
  });

  Map<String, dynamic> toJson() {
    List<GeminiContentModel> _contents = contents;
    for (int i = 0; i < _contents.length; i++) {
      _contents[i].parts[0]["text"] = "$systemInstructions\niçerik:\n${_contents[i].parts[0]["text"]}";
    }
    return {
      'contents': contents.map((x) =>  x.toJson()).toList(),
      // 'systemInstructions': systemInstructions,
      'generationConfig': generationConfig.toJson(),
      'safetySettings': safetySettings.map((x) => x.toJson()).toList(),
    };
  }
}
