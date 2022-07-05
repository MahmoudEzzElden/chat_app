import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miniflutter/controller/providers/checkbox_provider.dart';
import 'package:miniflutter/controller/providers/edit_user_data.dart';
import 'package:miniflutter/controller/providers/gender_provider.dart';
import 'package:miniflutter/controller/providers/user_image.dart';
import 'package:miniflutter/view/screens/HomePage.dart';
import 'package:miniflutter/view/screens/SignUpScreen.dart';
import 'package:miniflutter/view/screens/chat_room.dart';
import 'package:miniflutter/view/screens/profile_image_edit.dart';
import 'package:miniflutter/view/screens/reset_password.dart';
import 'package:miniflutter/view/screens/user_profile_pic_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/screens/LogInScreen.dart';
late final goHome;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final ref= await SharedPreferences.getInstance();
  goHome=ref.getBool('goHome');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GenderProvider>(
            create: (context) => GenderProvider()),
        ChangeNotifierProvider<TermsProvider>(
            create: (context) => TermsProvider()),
        ChangeNotifierProvider<EditProvider>(
            create: (context) => EditProvider()),
        ChangeNotifierProvider<ImageHandler>(
            create: (context) => ImageHandler()),




      ],
      child: MyApp(),
    ),
  );
  configLoading(); // delete
}

//delete here
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LogInScreen.routeName: (context) => LogInScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomePage.routeName: (context) => HomePage(),
        ResetPassword.routeName: (context) => ResetPassword(),
        ChatRoom.routeName:(context)=>ChatRoom(),
        ImageEdit.routeName:(context)=>ImageEdit(),
        PictureMagnifier.routeName:(context)=>PictureMagnifier(),
      },
      home: Splash(),
      builder: EasyLoading.init(), //
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xFF585858),
        splashTransition: SplashTransition.fadeTransition,
splashIconSize:  MediaQuery.of(context).size.height,
        splash: Image.asset('assets/splash.png')
        ,
        nextScreen:(goHome==false || goHome==null) ? LogInScreen():HomePage());
  }
}
