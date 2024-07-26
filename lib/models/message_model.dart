import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String message;
  bool isBot;
  String language;
  String? editingMessage;
  DateTime? createdAt;
  TranslateModel? translate;

  MessageModel({
    required this.message,
    required this.isBot,
    required this.language,
    this.editingMessage,
    this.createdAt,
    this.translate,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'isBot': isBot,
      'language': language,
      'editingMessage': editingMessage,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'translate': translate?.toMap(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic>? translate = map['translate'];
    return MessageModel(
      message: map['message'].toString(),
      isBot: map['isBot'] as bool,
      language: map['language'].toString(),
      editingMessage: map['editingMessage'].toString(),
      createdAt: map['createdAt'] != null ? Timestamp.fromMillisecondsSinceEpoch(map['createdAt'] as int).toDate() : DateTime.now(),
      // createdAt: (map['createdAt'] as Timestamp).toDate(),
      translate: translate != null ? TranslateModel.fromMap(translate) : null,
    );
  }
}

class TranslateModel {
  final String language;
  final String message;

  TranslateModel({
    required this.language,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'message': message,
    };
  }

  factory TranslateModel.fromMap(Map<String, dynamic> map) {
    return TranslateModel(
      message: map['message'],
      language: map['language'],
    );
  }
}