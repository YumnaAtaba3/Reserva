import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditService extends StatefulWidget {
  @override
  EditServiceState createState() => EditServiceState();
}

class EditServiceState extends State<EditService> {
  final _formKey = GlobalKey<FormState>();
  String _serviceName = '';
  bool pillow = false;
  bool meals = false;
  bool blanket = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit Service',
        style: TextStyle(
            color: Color(0xFF064061),
            fontFamily: "DancingScript",
            fontSize: 35,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                  value: pillow,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      pillow = val!;
                    });
                  }),
              Text(
                "Pillow",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                width: 100,
              ),
              Checkbox(
                  value: meals,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      meals = val!;
                    });
                  }),
              Text(
                "Meals",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                width: 100,
              ),
              Checkbox(
                  value: blanket,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      blanket = val!;
                    });
                  }),
              Text(
                "Blanket",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          )
          /*Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  labelText: 'Meals',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _serviceName = value!;
                },
              ),
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  labelText: 'Pillow',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _serviceName = value!;
                },
              ),
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  labelText: 'Blanket',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _serviceName = value!;
                },
              ),
            ],
          ),
        ),*/
          ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF064061)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Navigator.pop(context);
                }
              },
              child: Text(
                'Edit',
                style: TextStyle(color: Color(0xFF064061)),
              ),
            )
          ],
        ),
      ],
    );
  }
}
