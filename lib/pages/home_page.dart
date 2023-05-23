import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/models/data_models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

Future<DataModel?> submitData(String name, String job) async {
  var response = await http.post(Uri.https('reqres.in', 'api/users'), body: {
    "name": name,
    'job': job,
  });

  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    dataModelFromJson(responseString);
  } else
    return null;
}

class _HomePageState extends State<HomePage> {
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Http Post Method'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name here...',
                ),
                controller: nameController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Job Title here...',
                ),
                controller: jobController,
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String job = jobController.text;

                  DataModel? data = await submitData(name, job);
                  setState(() {
                    _dataModel = data;
                  });
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
