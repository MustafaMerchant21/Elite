import 'package:elite/core/common/widgets/loader.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:elite/core/utils/show_snackbar.dart';
import 'package:elite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:elite/features/auth/presentation/pages/home_page.dart';
import 'package:elite/features/auth/presentation/widgets/auth_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final newPwdController = TextEditingController();
  final cnfrmPwdController = TextEditingController();

  static _loginButtons(String image, Function()? onPress) => SizedBox(
        width: 70,
        child: IconButton(
          onPressed: onPress,
          icon: Image.asset(
            '$imgPath/$image.png',
          ),
          iconSize: 10,
          splashColor: Colors.blue,
          // focusColor: Colors.blue,
        ),
      );

  static _toLogin(Color color) => TextStyle(
        fontFamily: '$font Semi Expanded Heavy',
        fontSize: 15,
        color: color,
      );
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    newPwdController.dispose();
    cnfrmPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              // const Spacer(),
              Stack(children: [
                Image.asset(
                  '$imgPath/dots.png',
                  width: 62,
                ),
                const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Expanded(
                    child: Text(
                      "ELITE",
                      style: TextStyle(
                        color: AppPalette.backgroundColor,
                        fontFamily: '$font Expanded Heavy',
                        // fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ]),
              // const Spacer(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppPalette.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(130),
                    ),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(130),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              showSnackBar(context, state.message);
                            } else if (state is AuthSuccess) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (_) => HomePage(),
                                  ),
                                  (route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Loader();
                            }
                            return Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Register",
                                    style: TextStyle(
                                      color: AppPalette.primaryColor,
                                      fontSize: 36,
                                      fontFamily: '$font Semi Expanded Heavy',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      AuthField(
                                        text: "First Name",
                                        xpand: true,
                                        controller: fNameController,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      AuthField(
                                        text: "Last Name",
                                        xpand: true,
                                        controller: lNameController,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthField(
                                    text: "Email",
                                    xpand: false,
                                    controller: emailController,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthField(
                                    text: "New Password",
                                    xpand: false,
                                    controller: newPwdController,
                                    isObscure: true,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthField(
                                    text: "Confirm Password",
                                    xpand: false,
                                    controller: cnfrmPwdController,
                                    isObscure: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _loginButtons(
                                          'google login', googleSignUp()),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      _loginButtons(
                                          'facebook login', facbookSignUp()),
                                      _loginButtons(
                                          'apple login', appleSignUp()),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already have an account?",
                                          style: _toLogin(
                                              AppPalette.productBrandColor)),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            CupertinoPageRoute(
                                              builder: (context) {
                                                return const LoginPage();
                                              },
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          overlayColor: WidgetStateProperty.all(
                                              const Color(0x12171a1e)),
                                        ),
                                        child: Text(
                                          "Login",
                                          style: _toLogin(AppPalette.textColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          if (cnfrmPwdController.text.trim() ==
                                              newPwdController.text.trim()) {
                                            print('=== Passwords match! ==');
                                            context.read<AuthBloc>().add(
                                                  AuthSignUp(
                                                    name:
                                                        "${fNameController.text.trim()} ${lNameController.text.trim()}",
                                                    email: emailController.text
                                                        .trim(),
                                                    password: newPwdController
                                                        .text
                                                        .trim(),
                                                  ),
                                                );
                                            // Todo: User verification
                                            // User? user = FirebaseAuth.instance.currentUser;
                                            // if (user!= null && !user.emailVerified) {
                                            //   await user.sendEmailVerification();
                                            // }
                                            // _showEmailVerificationDialog();
                                            print('=== User Created! ==');
                                          } else {
                                            print(
                                                '=== Passwords do not match! ==');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Passwords do not match!'),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text("Register"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Function()? googleSignUp() {}

  Function()? facbookSignUp() {}

  Function()? appleSignUp() {}

  Future<void> _showEmailVerificationDialog() async {
    textStyle({required bool isTitle}) => TextStyle(
        color: AppPalette.textColor,
        fontFamily: isTitle ? "$font Black" : "$font Bold");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Verify Your Email',
            style: textStyle(isTitle: true),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An email has been sent for verification.',
                  style: textStyle(isTitle: false),
                ),
                Text(
                  'Please Verify your email address.',
                  style: textStyle(isTitle: false),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Okay',
                style: textStyle(isTitle: false),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
