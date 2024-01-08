import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thought Capturer',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class Thought {
  final String message;
  final DateTime timestamp;

  Thought(this.message, this.timestamp);
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _thoughtController = TextEditingController();
  final List<Thought> _thoughts = [];

  void _captureThought() {
    setState(() {
      _thoughts.add(Thought(_thoughtController.text, DateTime.now()));
      _thoughtController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thought Capturer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true, // To scroll to the end when a new thought is added
              child: Column(
                children: [
                  for (int index = 0; index < _thoughts.length; index++)
                    Column(
                      children: [
                        if (index > 0)
                          Container(
                            width: 2.0,
                            height: 10.0,
                            color: Colors.blue, // Change the color as needed
                          ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Colors.blue), // Change the color as needed
                          ),
                          child: ListTile(
                            title: Text(
                              _thoughts[index].message,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            subtitle: Text(
                              '${_thoughts[index].timestamp.toLocal()}',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _thoughtController,
                    decoration: InputDecoration(
                      hintText: 'Enter your thought...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _captureThought,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
