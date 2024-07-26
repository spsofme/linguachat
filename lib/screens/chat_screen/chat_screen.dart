import 'package:flutter/material.dart';
import 'package:linguachat/components/card_component.dart';
import 'package:linguachat/models/message_model.dart';
import 'package:linguachat/services/gemini_serivce.dart';
import 'package:linguachat/services/message_service.dart';
import 'package:linguachat/utils/color_util.dart';
import 'package:linguachat/widgets/page_widgets/back_page_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<MessageModel> messages = [];
  String language = "";
  bool firstLoad = true;
  bool waiting = false;

  void getMessages(BuildContext context, bool firstLoad) {
    if (!firstLoad) return;

    final String language =
        ModalRoute.of(context)!.settings.arguments as String;

    setState(() {
      this.language = language;
      firstLoad = false;
    });

    MessageService().getAll(language).then((value) {
      setState(() {
        messages = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getMessages(context, firstLoad);

    return BackPageWidget(
      context,
      color: ColorUtil.white2,
      header: Text(language, style: const TextStyle(fontSize: 28)),
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: messages.map((MessageModel message) {
                    return MessageCard(
                      message.isBot,
                      message.message,
                      message.isBot
                          ? (message.translate?.message ?? "")
                          : (message.editingMessage ?? ""),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: 4,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        filled: true,
                        fillColor: ColorUtil.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (waiting)
                    const CircularProgressIndicator()
                  else
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_messageController.text.trim() == "") return;
                        setState(() {
                          waiting = true;
                        });
                        MessageModel message = MessageModel(
                          message: _messageController.text.trim(),
                          isBot: false,
                          language: language,
                          createdAt: DateTime.now(),
                        );
                        MessageService().add(message).then((messageValue) {
                          setState(() {
                            messages.add(messageValue);
                          });
                          GeminiSerivce()
                              .sendMessage(messageValue)
                              .then((geminiValue) {
                            // setState(() {
                              messageValue.editingMessage = geminiValue.editingMessage;
                              MessageService()
                                  .update(messageValue.id!, messageValue)
                                  .then((updateMessageValue) {
                                messages.add(geminiValue);
                                setState(() {
                                  waiting = false;
                                });
                              });
                            // });
                          });
                        });
                        _messageController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageCard extends StatefulWidget {
  final bool isBot;
  final String message;
  final String subContent;

  const MessageCard(this.isBot, this.message, this.subContent, {super.key});

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  double iconSize = 17;
  bool subContentVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          right: widget.isBot ? 50 : 0, left: (!widget.isBot) ? 50 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!widget.isBot)
            IconButton(
              onPressed: () {
                setState(() {
                  subContentVisible = !subContentVisible;
                });
              },
              icon: Icon(
                Icons.check,
                size: iconSize,
              ),
            ),
          Expanded(
            child: CardComponent(
              color: widget.isBot ? ColorUtil.green2 : ColorUtil.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    textAlign: TextAlign.start,
                  ),
                  if (subContentVisible)
                    Text(
                      widget.subContent,
                      style: const TextStyle(color: ColorUtil.blue2),
                    )
                ],
              ),
            ),
          ),
          if (widget.isBot)
            IconButton(
              onPressed: () {
                setState(() {
                  subContentVisible = !subContentVisible;
                });
              },
              icon: Icon(
                Icons.translate,
                size: iconSize,
              ),
            ),
        ],
      ),
    );
  }
}
