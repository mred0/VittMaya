import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vittamaya/auth/auth_error.dart';
import 'package:vittamaya/screens/sign_up_screen.dart';
import 'package:vittamaya/widgets/common_button_widget.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Lottie.asset('assets/save-money.json',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                  reverse: true),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'It\'s Time to Manage Your Money And Time With VittMaya',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CommonButtonWidget(
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                maxwidth: 300,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const LoginScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                    ),
                  );
                },
                buttonColor: const Color(0xff2B2E4A),
                text: 'Login',
              ),
              const SizedBox(
                height: 30,
              ),
              CommonButtonWidget(
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                maxwidth: 300,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const Sign_UpScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                    ),
                  );
                },
                buttonColor: const Color(0xffCA8A8B),
                text: 'Sign_Up',
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: authErrorRegister != ''
                      ? Text(
                          authErrorRegister.split(']')[1],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
