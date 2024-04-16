import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:to_do_app/Screens/Home_page.dart';
import 'package:to_do_app/Screens/SignInPage.dart';
import 'package:to_do_app/Services/Auth_Service.dart';
import 'Screens/SignupPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 Widget currPage = SignupPAge();
 AuthClass authClass = AuthClass();


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
  String? token = await authClass.getToken();
  if(token!= null){
    setState(() {
      currPage = HomePage();
    });

  }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currPage,
    );
  }
}
