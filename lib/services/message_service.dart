import 'package:linguachat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<MessageModel>> getAll(String language) async {
    List<MessageModel> messages = [];

    final ref = db.collection("messages").where("language", isEqualTo: language).orderBy("createdAt", descending: false);
    final snapshot = await ref.get();

    for (var doc in snapshot.docs) {
      var message = MessageModel.fromMap(doc.data());
      messages.add(message);
    }

    return messages;
  }

  Future<MessageModel> add(MessageModel message) async {
    final ref = db.collection("messages");
    print("ref.id");
    await ref.add(message.toMap()).then((value) {
      message.id = value.id;
    });
    return message;
  }

  Future<MessageModel> update(String id, MessageModel message) async {
    final ref = db.collection("messages").doc(id);
    await ref.update(message.toMap());

    return message;
  }
}
