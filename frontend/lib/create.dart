import 'package:flutter/material.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  final Client client;

  const CreatePage({super.key, required this.client});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();

  _createNote() {
    widget.client.post(createURL, body: {"body": controller.text});

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      body: Column(
        children: [
          Text("CREATE PAGE"),
          TextField(
            controller: controller,
          ),
          ElevatedButton(onPressed: _createNote, child: Text("Create Note"))
        ],
      ),
    );
  }
}

// class CreatePage extends StatelessWidget {
//   const CreatePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Create"),
//       ),
//       body: Text("CREATE PAGE"),
//     );
//   }
// }
