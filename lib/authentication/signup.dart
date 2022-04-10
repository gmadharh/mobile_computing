import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/signin.dart';
import '../main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);
  static TextEditingController nameController = TextEditingController();

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isError = false;
  String errorName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Create An Account"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Color.fromARGB(255, 112, 180, 236),
              Color.fromARGB(255, 150, 231, 200)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: UserTextField("Enter Name", Icons.person_outline, false, SignupScreen.nameController),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: UserTextField("Enter Email", Icons.mail_outline, false,_emailController),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: UserTextField("Enter Password", Icons.lock_outline, true,_passwordController),
              ),
              SizedBox(height: 20),
              Text(
                isError? errorName: "",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                    print("Created Account");
                    setState(() {
                      isError = false;
                      errorName = "";
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
                  }).onError((error, stackTrace) {
                    print(error.toString());
                    setState(() {
                      isError = true;
                      if(error.toString() == "[firebase_auth/unknown] Given String is empty or null"){
                        errorName = "One or more fields are empty.";
                      } else if(error.toString() == "[firebase_auth/invalid-email] The email address is badly formatted."){
                        errorName = "Invalid email format [example format: example@gmail.com]";
                      } else if(error.toString() == "[firebase_auth/weak-password] Password should be at least 6 characters"){
                        errorName = "Password should be atleast 6 characters";
                      } 
                    });
                  });
                } ,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states){return Colors.white;} ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}