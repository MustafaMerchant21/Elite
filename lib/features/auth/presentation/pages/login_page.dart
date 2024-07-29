import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_main.dart';
import 'package:elite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:elite/features/auth/presentation/pages/signup_page.dart';
import 'package:elite/features/auth/presentation/widgets/auth_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late User? user;
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  static _loginButtons(String image, Function()? onPress) => SizedBox(
    width: 70,
    child: InkWell(
      onTap: onPress,
      splashColor: AppPalette.textColor,
      child: IconButton(
        tooltip: image.toUpperCase(),
        onPressed: onPress,
        icon: Image.asset(
          '$imgPath/$image.png',
        ),
        iconSize: 30,
      ),
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
    pwdController.dispose();
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
              Stack(
                children: [
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
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                user = FirebaseAuth.instance.currentUser;

                                /// Todo: User verification

                                if (user!.uid == 'bgC5H0OFYJfgNed6Mg766zt4Fmd2' ) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const AdminMain(),
                                    ),
                                  );
                                }else{
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                }
                              } else if (state is AuthFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                  ),
                                );
                              }
                            },
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: AppPalette.primaryColor,
                                      fontSize: 36,
                                      fontFamily: '$font Semi Expanded Heavy',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                                    text: "Password",
                                    xpand: false,
                                    controller: pwdController,
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
                                          'google login', googleLogin()),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _loginButtons(
                                          'facebook login', facbookLogin()),
                                      _loginButtons('apple login', appleLogin()),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Need an account?",
                                          style: _toLogin(
                                              AppPalette.productBrandColor)),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            CupertinoPageRoute(
                                              builder: (context) {
                                                return const SignupPage();
                                              },
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          overlayColor:
                                          WidgetStateProperty.all(
                                              const Color(0x12171a1e)),
                                        ),
                                        child: Text(
                                          "Register",
                                          style:
                                          _toLogin(AppPalette.textColor),
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
                                          print('=== Login Initiated ==');
                                          context.read<AuthBloc>().add(
                                            AuthLogin(
                                              email: emailController.text
                                                  .trim(),
                                              password: pwdController.text
                                                  .trim(),
                                            ),
                                          );
                                          print('=== User Logged In! ==');
                                        } else {
                                          print(
                                              '=== User not validated! ==');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'User not validated!'),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text("Login"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
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

  Function()? googleLogin() {}

  Function()? facbookLogin() {}

  Function()? appleLogin() {}

  Future<void> _showEmailVerificationDialog() async {
    textStyle({required bool? isTitle}) => TextStyle(
      color: AppPalette.textColor,
      fontFamily: isTitle! ? "$font Black" : "$font Bold"
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Verify Your Email', style: textStyle(isTitle: true),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An email has been sent for verification.', style: textStyle(isTitle: false),),
                Text('Please Verify your email address.', style: textStyle(isTitle: false),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay', style: textStyle(isTitle: false),),
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
