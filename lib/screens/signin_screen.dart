import 'package:chatappnew/screens/auth_screen.dart';
import 'package:chatappnew/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';




class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
          child: Card(
            margin: EdgeInsets.all(30),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter  a user name with at lease 4 chars';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Adress'),
                      onChanged: (value) {
                        email = value;
                      },
                    ),

                    TextFormField(

                      key: ValueKey('password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter  a password with at lease 7 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'password'),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 30),
                    RaisedButton(onPressed: () async{
                      try {
                        final user =
                        await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if (user != null) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                        }
                      }
                      catch (e) {
                        print(e);
                      }
                    },
                      child: Text('Sign up', style: TextStyle(color: Colors.white),),
                    ),
                    FlatButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));

                    },
                        child: Text('Creat a new user'))





                  ],

                ),
              ),
            ),
          ),
        ));

  }
}
