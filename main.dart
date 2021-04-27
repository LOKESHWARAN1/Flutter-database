import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:database/addUsers.dart';
import 'package:database/updateUsers.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{'/addUsers': (context) => AddUsers()},
    );
  }
}

Future<List> getData() async {
  // var url = Uri.parse('http://192.168.33.136/API/getData.php');
  var url = Uri.parse('https://flutterlokesh.000webhostapp.com/getData.php');
  final response = await http.get(url);
  var dataReceived = json.decode(response.body);
  return dataReceived;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD'),
      ),
      body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error in loading' + snapshot.error.toString());
            }
            return snapshot.hasData
                ? ItemList(list: snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addUsers');
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  const ItemList({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateUsers(
                              id: list[i]['ID'],
                              name: list[i]['NAME'],
                              email: list[i]['EMAIL'],
                            )));
              },
              leading: CircleAvatar(
                child: Text(
                    list[i]['NAME'].toString().substring(0, 1).toUpperCase()),
              ),
              title: new Text(
                list[i]['NAME'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                list[i]['EMAIL'],
                style: TextStyle(fontSize: 15),
              ),
            ),
          );
        });
  }
}
