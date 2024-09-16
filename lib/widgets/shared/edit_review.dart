import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditReview extends StatefulWidget {
  @override
  EditReviewState createState() => EditReviewState();
}

class EditReviewState extends State<EditReview> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _review = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit Review',
        style: TextStyle(
            color: Color(0xFF064061),
            fontFamily: "DancingScript",
            fontSize: 35,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 200,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  labelText: 'User Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),
              TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  labelText: 'Review:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a review';
                  }
                  return null;
                },
                onSaved: (value) {
                  _review = value!;
                },
              ),
            ],
          ),
        ),
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
