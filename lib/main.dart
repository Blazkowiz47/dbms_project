import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test123"),
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("data"),
          Image(image: AssetImage("images/140193.jpg")),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("clk"),
        onPressed: () => Null,
      ),
    );
  }
}
