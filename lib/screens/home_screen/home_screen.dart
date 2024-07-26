import 'package:flutter/material.dart';
import 'package:linguachat/components/card_component.dart';
import 'package:linguachat/models/language_model.dart';
import 'package:linguachat/services/language_service.dart';
import 'package:linguachat/utils/color_util.dart';
import 'package:linguachat/widgets/page_widgets/page_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<String> languages = [
  //   "English",
  //   "German",
  //   "Spanish",
  //   "French",
  // ];

  List<LanguageModel> languages = [];

  @override
  void initState() {
    super.initState();

    LanguageService().getAll().then((value) {
      setState(() {
        languages = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      context,
      color: ColorUtil.white2,
      header: const Text("Chats", style: TextStyle(fontSize: 28)),
      child: Column(
        children: [
          // CardComponent(
          //   child: Column(
          //     children: [
          //       TextButton(
          //         onPressed: () {},
          //         child: const Text(
          //           "Ürün Ekle",
          //           style: TextStyle(color: ColorUtil.purple),
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () {},
          // ),

          SingleChildScrollView(
            child: Column(
              children: List.generate(
                languages.length,
                (index) => LanguageCard(
                    languages[index].name, languages[index].lastMessage),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productCard(String title, String content) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }

  Widget LanguageCard(String title, String content) {
    return Container(
      width: double.infinity,
      child: CardComponent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, '/chat', arguments: title).then((value) {
            LanguageService().getAll().then((value) {
              setState(() {
                languages = value;
              });
            });
          });
        },
      ),
    );
  }
}
