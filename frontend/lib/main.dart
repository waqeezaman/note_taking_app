import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/create.dart';
import 'package:frontend/note.dart';
import 'package:frontend/update.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _retrieveNotes();
  }

  void _addNote() {}

  _retrieveNotes() async {
    notes = [];

    Response response = (await client.get(retrieveURL));

    print("THE RESPONSE");
    print(response.body);

    List response_body = json.decode(response.body);

    response_body.forEach((element) {
      notes.add(Note.fromMap(element));
    });

    setState(() {});
  }

  _deleteNote(int id) async {
    Response response = await client.delete(getDeleteURL(id));
    print("DELETING");
    print(response);
    _retrieveNotes();
  }

  _navigateCreatePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePage(
            client: client,
          ),
        )).then((_) => _retrieveNotes());
  }

  // _navigateUpdatePage(int noteID) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => UpdatePage(
  //                 client: client,
  //                 noteId: noteID,
  //               )));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  title: Text(notes[index].body),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteNote(notes[index].id),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdatePage(
                                  client: client,
                                  note: notes[index],
                                ))).then((_) => _retrieveNotes())
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateCreatePage,
        tooltip: "Add Note",
        child: const Icon(Icons.add),
      ),
    );
  }
}
