import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_computing/authentication/resetPassword.dart';
import 'package:mobile_computing/authentication/signup.dart';
import '../main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isError = false;
  String errorName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: <Widget>[
              SizedBox(height: 150,),
              Text(
                "FitnessScape",
                style: GoogleFonts.caveat(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    ), 
                  ),
                ),
                SizedBox(height: 75,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: UserTextField("Enter Email", Icons.mail_outline, false,_emailController),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: UserTextField("Enter Password", Icons.lock_outline, true,_passwordController),
                ),

                forgotPassword(context),
                SizedBox(height: 15,),
                Text(
                  isError? errorName: "",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value)  {
                      setState(() {
                        isError = false;
                        errorName = "";
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
                    }).onError((error, stackTrace) {
                      print(error.toString());
                      setState(() {
                        isError = true;
                        if (error.toString() == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
                          errorName = "Email is not on record.";
                        } else if(error.toString() == "[firebase_auth/unknown] Given String is empty or null"){
                          errorName = "One or more fields are empty.";
                        } else if(error.toString() == "[firebase_auth/invalid-email] The email address is badly formatted."){
                          errorName = "Invalid email format [example format: example@gmail.com]";
                        } else {
                          errorName = "Invalid password for the given email.";
                        }
                      });
                    });
                    
                  } ,
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states){return Colors.white;} ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                  } ,
                  child: const Text(
                    "Create Account",
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

TextField UserTextField(String text, IconData icon, bool isPassword, TextEditingController controller){
  return TextField(
    controller:  controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white.withOpacity(0.8),
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white60,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.8),
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ), 
    ),
    keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

class AlertError extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Widget forgotPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width /1.2,
    height: 40,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.white.withOpacity(0.7)),
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword())),
    ),
  );
}