import 'package:chatapp/constants.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screen/chat_app.dart';
import 'package:chatapp/screen/register_screen.dart';
import 'package:chatapp/widget/custom_botton-widgwt.dart';
import 'package:chatapp/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico-Regular',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  obscureText: false,
                  hintText: 'Email',
                  onChange: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                    obscureText: true,
                    onChange: (data) {
                      password = data;
                    },
                    hintText: 'PassWord'),
                const SizedBox(height: 20),
                CustomButtonWidget(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          isLoading = true;
                          setState(() {});
                          await customLogin();
                          Navigator.pushNamed(
                            context,
                            ChatApp.id,
                            arguments: email,
                          );

                          ShowSnackBar(context, 'Successed');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ShowSnackBar(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            ShowSnackBar(context,
                                'Wrong password provided for that user.');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    title: 'login'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don’t have an account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: const Text(
                        ' Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> customLogin() async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
