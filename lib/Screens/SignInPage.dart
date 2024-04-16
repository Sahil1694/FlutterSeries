import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:to_do_app/Screens/Home_page.dart';
import 'package:to_do_app/Screens/SignInPage.dart';


class SignInPAge extends StatefulWidget {
  const SignInPAge({Key? key}) : super(key: key);

  @override
  State<SignInPAge> createState() => _SignInPAgeState();
}

class _SignInPAgeState extends State<SignInPAge> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign In",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem("assets/google.svg", 'Continue with Google', 25 ),
              SizedBox(
                height: 15,
              ),
              buttonItem("assets/phone.svg" , "Continue with Mobile" , 30),
              SizedBox(
                height: 15,
              ),
              Text("OR" , style: TextStyle(color: Colors.white , fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              textItem('E-Mail', _emailController, false),
              SizedBox(
                height: 15,
              ),
              textItem("Password", _pwdController, true),

              SizedBox(
                height: 30,
              ),
              colorButton(),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you don't  have an Account ?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),

                  Text("Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Fogot Password !",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /////////////////Widget Button Item /////////////////////////////////////////////////////////

  Widget buttonItem(String imagepath, String buttonName, double size){
    return Container(
      width: MediaQuery.of(context).size.width-50,
      height: 60,
      child: Card(
        color:  Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side:  BorderSide(
              width: 1,
              color: Colors.grey,
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagepath,
              height: size,
              width: size,
            ),


            SizedBox(
              width: 25,
            ),
            Center(
              child: Text(buttonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
  /////////////////Color Button Item /////////////////////////////////////////////////////////


  Widget colorButton(){
    return InkWell(
      onTap: ()async {
        try {
          firebase_auth.UserCredential userCredential = await firebaseAuth.
          signInWithEmailAndPassword(
              email: _emailController.text, password: _pwdController.text);
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
                  (route) => false);
        }
        catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });


        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)]),
        ),
        child: Center(
          child: circular?CircularProgressIndicator():
          Text(
            "Sign IN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  /////////////////Widget Text Item /////////////////////////////////////////////////////////
  Widget textItem(String label_text, TextEditingController controller, bool obscureText ){
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(

          fontSize: 17,
          color: Colors.white,

        ),



        decoration: InputDecoration(
            labelText: label_text,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),

            focusedBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Colors.amber,
                )
            ),


            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                )
            )
        ),
      ),
    );
  }
}
/////////////////Color Button Item /////////////////////////////////////////////////////////


