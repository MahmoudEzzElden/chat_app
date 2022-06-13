
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../custom_widgets/custom_button.dart';
import '../styles/input_decoration.dart';

class ResetPassword extends StatelessWidget {
  static const routeName = 'ResetPassword';
  final emailController=TextEditingController();
  final formKey = GlobalKey<FormState>();

  ResetPassword({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.white, Colors.black12]),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 5),
                  child: TextFormField(
                    controller: emailController,

                    validator: (name) =>
                    name!.isEmpty ? 'Enter an Email' : null,
                    decoration: decorationText(
                        labelText: 'Email', prefixIcon: Icons.mail),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CustomElevatedButton(
                    text: 'Reset Password',
                    width: 300.0,
                    height: 50.0,
                    onPressed: () {
                      EasyLoading.show(status: '');
                      FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
                      EasyLoading.showSuccess('Your Password has been Reset, Check your Mail!');
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
