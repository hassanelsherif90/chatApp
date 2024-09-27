import 'package:chatapp/constants.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screen/chat_app.dart';
import 'package:chatapp/widget/custom_botton-widgwt.dart';
import 'package:chatapp/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

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
                const SizedBox(height: 15),
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
                      'Register',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  onChange: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
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
                        await registerUesr();
                        Navigator.pushNamed(context, ChatApp.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          ShowSnackBar(context,
                              'The account already exists for that email...');
                        }
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  title: 'Register',
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' Log In',
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

  Future<void> registerUesr() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
