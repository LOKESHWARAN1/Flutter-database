import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUsers extends StatefulWidget {
  @override
  _AddUsersState createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final txtFullName = new TextEditingController();
  final txtEmail = new TextEditingController();
  bool _valName = false;
  bool _valEmail = false;

  Future _saveDetails(String name, String email) async {
    //var url = Uri.parse('http://192.168.33.136/API/saveData.php');
    var url = Uri.parse('https://flutterlokesh.000webhostapp.com/saveData.php');
    final response = await http.post(url, body: {"name": name, "email": email});
    var res = response.body;
    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error :" + res);
    }
  }

  @override
  void dispose() {
    txtFullName.dispose();
    txtEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
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
                  child: Text('Save Details'),
                  onPressed: () {
                    setState(() {
                      txtFullName.text.isEmpty
                          ? _valName = true
                          : _valName = false;
                      txtEmail.text.isEmpty
                          ? _valEmail = true
                          : _valEmail = false;
                      if (_valName == false && _valEmail == false) {
                        _saveDetails(txtFullName.text, txtEmail.text);
                      }
                    });
                  },
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.red,
                  child: Text('Clear'),
                  onPressed: () {
                    txtFullName.clear();
                    txtEmail.clear();
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
