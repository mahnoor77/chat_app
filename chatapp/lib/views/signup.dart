import 'package:chatapp/net/database.dart';
import 'package:chatapp/net/flutterfire.dart';
import 'package:chatapp/views/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/views/home.dart';
import 'package:chatapp/net/flutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  List li = [];

  //String name = userController.text;

  //Map<String, String> userInfo = {
  //"name": userController.text,
  // "email": emailController.text
  //};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      appBar: AppBar(
        title: const Text('ChatApp'),
        backgroundColor: Color.fromARGB(255, 59, 167, 230),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "username",
                //hintStyle: TextStyle(
                //color: Colors.white,
                //  ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "email",
                // hintStyle: TextStyle(
                // color: Colors.white,
                //),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "password",
                // hintStyle: TextStyle(
                // color: Colors.white,
                //),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'forgorpassword?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 120, 218, 218), // background
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                  shape: StadiumBorder() // foreground
                  ),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("email", emailController.text);

                await InsertData(userController.text, emailController.text);
                bool shouldNavigate = await registerUser(
                    emailController.text, passwordController.text);
                if (shouldNavigate) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                }
                //List resultant = await getUserData();

                // print(resultant[1]['email']);
                //print(resultant[1]);

                //await FirebaseFirestore.instance
                //  .collection("Users")
                //.snapshots();
              },
              child: Text('Sign Up'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 214, 228, 230), // background
                  onPrimary: Color.fromARGB(255, 170, 153, 153),
                  padding: EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                  shape: StadiumBorder() // foreground
                  ),
              onPressed: () {},
              child: Text('Sign In with Google'),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text('Already have an account? SignIn')),
          ],
        ),
      ),
    );
  }
}
