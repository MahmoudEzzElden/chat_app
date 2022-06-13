import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miniflutter/controller/providers/checkbox_provider.dart';
import 'package:miniflutter/controller/providers/gender_provider.dart';
import 'package:miniflutter/controller/providers/user_image.dart';
import 'package:miniflutter/services/firebase_auth.dart';
import 'package:miniflutter/view/custom_widgets/profile_image.dart';
import 'package:miniflutter/view/styles/input_decoration.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {
  static const String routeName = 'SignUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userName = TextEditingController();

  final age = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final emailController = TextEditingController();

  FireBaseService fbs = FireBaseService();

  @override
  void dispose() {
    userName.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Row(
                children: [
                  Text(
                    'Create\nAccount',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  SizedBox(
                    width: 70,
                  ),


                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            ProfileImage(
                              onTap: (){
                                showDialog(context: context, builder:(BuildContext context)=>AlertDialog(
                                  title: Text('Choose a method '),
                                  actions: [
                                    ListTile(

                                      leading: Icon(Icons.image),
                                      title: TextButton(onPressed: () {
                                        Provider.of<ImageHandler>(context,listen: false).pickGalleryImage();
                                        Navigator.pop(context);
                                      }, child: Text('Pick From Gallery'),),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: TextButton(onPressed: () {
                                        Provider.of<ImageHandler>(context,listen: false).pickCameraImage();
                                        Navigator.pop(context);
                                      }, child: Text('Pick From Camera'),),
                                    ),
                                    
                                  ],
                                )
                                );
                              },
                              image: Provider.of<ImageHandler>(context).selectedImage,),
                            SizedBox(height: 40,),
                            TextFormField(
                              maxLength: 15,
                              controller: userName,
                              validator: (name) =>
                              name!.isEmpty ? 'Enter a Name' : null,
                              decoration: decorationText(
                                  labelText: 'Name', prefixIcon: Icons.person),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (email) => email!.isEmpty ||
                                  !EmailValidator.validate(email)
                                  ? 'Invalid Email'
                                  : null,
                              decoration: decorationText(
                                  labelText: 'Email', prefixIcon: Icons.email),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: age,
                              keyboardType: TextInputType.number,
                              validator: (age) =>
                              age == null ? 'Enter a valid Age' : null,
                              decoration: decorationText(
                                  labelText: 'Age', prefixIcon: Icons.person),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 30),
                              child: Consumer<GenderProvider>(
                                builder: (context, provider, child) {
                                  return DropdownButton(
                                    hint: Text(
                                      'Select Gender',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    value: provider.genderValue,
                                    onChanged: (newGender) {
                                      provider
                                          .selectedGender(newGender as String);
                                    },
                                    items: provider.genderList.map((gender) {
                                      return DropdownMenuItem(
                                          value: gender, child: Text(gender));
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              validator: (password) =>
                              password == null ? 'Enter a Password' : null,
                              decoration: decorationText(
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (confirmPassword) {
                                if (confirmPassword!.isEmpty) {
                                  return 'Enter a Password';
                                } else if (passwordController.text !=
                                    confirmPassword) {
                                  return 'Password is Incorrect';
                                } else {
                                  return null;
                                }
                              },
                              decoration: decorationText(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icons.lock),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Consumer<TermsProvider>(
                              builder: (context, provider, child) {
                                return CheckboxListTile(
                                    controlAffinity:
                                    ListTileControlAffinity.leading,
                                    value: provider.checkBox,
                                    title: Text(
                                        'I Agree to the terms and conditions'),
                                    onChanged: (value) {
                                      Provider.of<TermsProvider>(context,
                                          listen: false)
                                          .selectedValue(value as bool);
                                    });
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        if (formKey.currentState!.validate() &&
                                            Provider.of<TermsProvider>(context,
                                                listen: false)
                                                .checkBox ==
                                                true) {
                                          await FireBaseService.register(
                                              context,
                                              emailController.text.trim(),
                                              passwordController.text.trim(),
                                              userName.text.trim(),
                                              age.text.trim(),
                                              Provider.of<GenderProvider>(
                                                  context,
                                                  listen: false)
                                                  .genderValue
                                                  .toString());
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
