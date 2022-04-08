import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../authentication/signin.dart';
import '../main.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key? key }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailController = TextEditingController();
  bool isError = false;
  String errorName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Reset Password"),
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
                child: UserTextField("Enter Email", Icons.mail_outline, false,_emailController),
              ),
              SizedBox(height: 15),
              Text(
                isError? errorName: "",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value) { 
                    setState(() {
                      isError = false;
                      errorName = "";
                    });
                    Navigator.of(context).pop();
                  }).onError((error, stackTrace) {
                    isError = true;
                    print(error.toString());
                    setState(() {
                      if(error.toString() == "[firebase_auth/unknown] Given String is empty or null"){
                        errorName = "Field is empty.";
                      } else if(error.toString() == "[firebase_auth/invalid-email] The email address is badly formatted."){
                        errorName = "Invalid email format [example format: example@gmail.com]";
                      } else if (error.toString() == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
                        errorName = "Email is not on record.";
                      }
                    });
                  });
                } ,
                child: const Text(
                  "Reset Password",
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