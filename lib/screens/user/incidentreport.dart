import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:iitm_android/widgets/image_picker_for_compl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _form = GlobalKey<FormState>();
  final formatter = DateFormat.yMd();
  var _isAuthenticating=false;
  var _isStored=false;
  File? _selectedImage1;
  var _enteredtitle = '';
  var _entereddesc = '';
  var _enteredsecid = '';
  //final String date = DateTime.now();
  //final  _entereddate = date.formattedDate;
  final _firebase = FirebaseAuth.instance;
  //String get formattedDate {
  //return formatter.format(date);
  DateTime date = DateTime.now();

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  //}

  void _hello() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      // show error message ...
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('incident_report_images')
          .child('$date.jpg');
      await storageRef.putFile(_selectedImage1!);
      final imageUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance.collection('messages').add({
        'number': _enteredsecid,
        'email': _enteredtitle,
        'pass': _entereddesc,
        'date': formattedDate,
        'image_url': imageUrl,

      });
      setState(() {
        _isAuthenticating = false;
        _isStored=true;
        _form.currentState?.reset();
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('User Inputs'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              width: 200,
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserImagePicker(
                          onPickImage: (pickedImage) {
                            _selectedImage1 = pickedImage;
                          },
                        ),

                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Number'),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          onSaved: (value) {
                            _enteredsecid = value!;
                          },
                          validator: (value) {
                            final RegExp regex = RegExp(r'^\d+(\.\d+)?$');
                            if (!regex.hasMatch(value!)) {
                              return 'Not Number';
                            }
                            return null;
                          },

                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          onSaved: (value) {
                            _enteredtitle = value!;
                          },
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Description'),
                          obscureText: false,
                          onSaved: (value) {
                            _entereddesc = value!;
                          },
                          validator: (value) {
                            if (value!.trim().length < 10) {
                              return 'Should contain min 10 characters';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          ElevatedButton(
                          onPressed: _hello,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child:  Text(!_isStored?'Submit':'Submitted'),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
