import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUsers extends StatefulWidget {
  final String id;
  final String name;
  final String email;

  const UpdateUsers({Key key, this.id, this.name, this.email})
      : super(key: key);
  @override
  _UpdateUsersState createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {
  final txtFullName = new TextEditingController();
  final txtEmail = new TextEditingController();
  bool _valName = false;
  bool _valEmail = false;

  String name;

  String email;

  Future _updateDetails(String name, String email) async {
    //var url = Uri.parse('http://192.168.33.136/API/updateUser.php');
    var url =
        Uri.parse('https://flutterlokesh.000webhostapp.com/updateUser.php');
    final response = await http
        .post(url, body: {"name": name, "email": email, "id": widget.id});
    var res = response.body;
    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error :" + res);
    }
  }

  Future _deleteDetails(String name, String email) async {
    //var url = Uri.parse('http://192.168.33.136/API/deleteUser.php');
    var url =
        Uri.parse('https://flutterlokesh.000webhostapp.com/deleteUser.php');
    final response = await http.post(url, body: {"id": widget.id});
    var res = response.body;
    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error :" + res);
    }
  }

  void dispose() {
    txtFullName.dispose();
    txtEmail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    txtFullName.text = widget.name;
    txtEmail.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Full Name',
                labelText: 'Enter Name',
                hintStyle: TextStyle(fontSize: 17.0),
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valName ? 'Name Can\'t Be Empty' : null,
              ),
              controller: txtFullName,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email id',
                labelText: 'Enter Email id',
                hintStyle: TextStyle(fontSize: 17.0),
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valEmail ? 'Email Can\'t Be Empty' : null,
              ),
              controller: txtEmail,
            ),
            ButtonBar(
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.green,
                  child: Text('Update Details'),
                  onPressed: () {
                    txtFullName.text.isEmpty
                        ? _valName = true
                        : _valName = false;
                    txtEmail.text.isEmpty
                        ? _valEmail = true
                        : _valEmail = false;
                    if (_valName == false && _valEmail == false) {
                      _updateDetails(txtFullName.text, txtEmail.text);
                    }
                  },
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.red,
                  child: Text('Delete'),
                  onPressed: () {
                    _deleteDetails(name, email);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
