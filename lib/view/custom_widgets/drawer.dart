import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/view/screens/LogInScreen.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text('Sign Out',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              onTap: () {
                showDialog(context: context, builder:(context)=> AlertDialog(
                  title: Text('You realy want to Sign out?'),
                  actions: [
                    TextButton(onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.pushNamed(context, LogInScreen.routeName));

                    }, child: Text('Yes')),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('No')),
                  ],
                ));



              },

            )
          ],
        ),
      ),
    );
  }
}
