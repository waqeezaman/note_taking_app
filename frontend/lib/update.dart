import 'package:flutter/material.dart';
import 'package:frontend/note.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final Note note;
  final Client client;
  const UpdatePage({super.key, required this.client, required this.note});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  _updateNote() {
    widget.client
        .put(getUpdateURL(widget.note.id), body: {"body": controller.text});

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // controller = TextEditingController(text: widget.note.body);
    controller.text = widget.note.body;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: Column(
        children: [
          Text("Update Page"),
          TextField(
            controller: controller,
          ),
          ElevatedButton(onPressed: _updateNote, child: Text("Update Note"))
        ],
      ),
    );
  }
}
