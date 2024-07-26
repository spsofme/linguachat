import 'dart:convert';
import 'dart:io';

import 'package:linguachat/models/ai/gemini/gemini_body_model.dart';
import 'package:linguachat/models/ai/gemini/gemini_content_model.dart';
import 'package:linguachat/models/message_model.dart';
import 'package:linguachat/services/message_service.dart';

class GeminiSerivce {
  late String model;
  late String version;
  late String apiKey;
  late String apiUrl;

  GeminiSerivce() {
    model = "gemini-1.5-pro";
    version = "v1beta";
    apiKey = "API_KEY";
    apiUrl =
        "https://generativelanguage.googleapis.com/$version/models/$model:generateContent?key=$apiKey";
  }

  Future<MessageModel> sendMessage(MessageModel message) async {
    GeminiBodyModel body = GeminiBodyModel(
      contents: [
        GeminiContentModel(
          role: "user",
          parts: [
            {"text": jsonEncode(message.toMap())}
          ],
        ),
      ],
    );

    HttpClient client = HttpClient();
    HttpClientRequest request = await client.postUrl(Uri.parse(apiUrl));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(jsonEncode(body.toJson())));
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    client.close();

    Map<String,dynamic> _response = jsonDecode(responseBody) as Map<String, dynamic>;
    _response = jsonDecode(_response["candidates"][0]["content"]["parts"][0]["text"].toString().replaceFirst("```json", "").replaceAll("```", "").replaceAll("\n", "")) as Map<String, dynamic>;

    MessageModel responseMessage = MessageModel.fromMap(_response);
    await MessageService().add(responseMessage);

    return responseMessage;
  }
}
