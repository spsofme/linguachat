import 'package:linguachat/models/language_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LanguageService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<LanguageModel>> getAll() async {
    List<LanguageModel> languages = [];

    final ref = db.collection("languages");
    final snapshot = await ref.get();


    for (var doc in snapshot.docs) {
      final messageRef = db.collection("messages").where("language", isEqualTo: doc.data()["name"].toString()).orderBy("createdAt", descending: true).limit(1);
      final messageSnapshot = await messageRef.get();
      var language = LanguageModel.fromMap(doc.data());
      language.lastMessage = messageSnapshot.docs.isNotEmpty ? messageSnapshot.docs.first.data()["message"] : "";
      languages.add(language);
    }

    return languages;
  }

  Future<LanguageModel> add(LanguageModel language) async {
    final ref = db.collection("messages");
    await ref.add(language.toMap());

    return language;
  }
}
