import 'package:chatappnew/screens/chat_screen.dart';
import 'package:chatappnew/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  late String email;
  late String userName;
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
                  validator: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Adress'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  key: ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Please enter  a user name with at lease 4 chars';
                    }

                  },
                  decoration: InputDecoration(labelText: 'User name'),
                  onChanged: (value) {
                    userName = value;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Please enter  a password with at lease 7 digits';
                    }
                  },
                  decoration: InputDecoration(labelText: 'password'),
                  onChanged: (value) {
                    password = value;
                  },
                ), 
                SizedBox(height: 30),
                RaisedButton(onPressed: () async{
                  try {
                    final newUser =
                    await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                  }
                      catch (e) {
                    print(e);
                      }
                },
                  child: Text('Register', style: TextStyle(color: Colors.white),),
                ),
                FlatButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SingIn()));

                },
                    child: Text('I already have an Account'))

                
                


              ],

            ),
          ),
        ),
      ),
    ));

  }
}
