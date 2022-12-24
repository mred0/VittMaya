import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vittamaya/controllers/email_and_password_controller.dart';
import 'package:vittamaya/screens/sign_up_screen.dart';

import '../auth/auth_error.dart';
import '../bloc/app_bloc.dart';
import '../widgets/common_button_widget.dart';
import '../widgets/text_formfeild_widget.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is AppStateLoggedIn) {
        return const HomeScreen();
      }
      if (state is AppStateLoggedOut) {
        return Scaffold(
          backgroundColor: const Color(0Xff282b2e),
          appBar: AppBar(
            leading: const BackButton(
              color: Color.fromARGB(255, 255, 248, 195),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/target_Vittmaya.json',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AppTextField(
                      controller: emailController,
                      fillcolor: const Color.fromARGB(255, 255, 248, 195),
                      textColor: const Color.fromARGB(255, 18, 40, 91),
                      hintText: 'Enter Email',
                      hintColor: Colors.black26,
                      bordercolor: Colors.transparent,
                      enabled: true,
                      removeBorder: true,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AppTextField(
                      controller: passwordController,
                      textColor: const Color.fromARGB(255, 18, 40, 91),
                      fillcolor: const Color.fromARGB(255, 255, 248, 195),
                      hintText: 'Enter Password',
                      onFieldSubmitted: (value) {
                        context.read<AppBloc>().add(AppEventLogIn(
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      hintColor: Colors.black26,
                      bordercolor: Colors.transparent,
                      enabled: true,
                      removeBorder: true,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, top: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                color: const Color(0Xff282b2e),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Container(
                                          height: 5,
                                          width: 50,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, top: 25),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Reset Password',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 248, 195),
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Insert your E-mail below \nWe gonna send you a link to reset your password',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.alternate_email,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 250,
                                                    child: TextField(
                                                      controller:
                                                          emailController,
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              248,
                                                              195)),
                                                      decoration: const InputDecoration(
                                                          hintText: 'E-mail ID',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      255,
                                                                      248,
                                                                      195)),
                                                          counterStyle: TextStyle(
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      255,
                                                                      248,
                                                                      195)),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.amber))),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25, bottom: 25),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: SizedBox(
                                          height: 50,
                                          width: 200,
                                          child: BlocBuilder<AppBloc, AppState>(
                                            builder: (context, state) {
                                              return MaterialButton(
                                                color: Colors.amber,
                                                onPressed: () {
                                                  // ignore: prefer_const_constructors

                                                  context.read<AppBloc>().add(
                                                      AppEventResetPassword(
                                                          email: emailController
                                                              .text));

                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CupertinoAlertDialog(
                                                      title: const Text(
                                                          'E-mail sended'),
                                                      content: const Text(
                                                          'An E-mail with your password recovery link was send to E-mail provided'),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          child:
                                                              const Text('Ok'),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: const Text('Send'),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 233, 199, 65),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: authErrorlogin != ''
                        ? Text(
                            textAlign: TextAlign.center,
                            authErrorlogin.split(']')[1],
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : CommonButtonWidget(
                          buttonPadding: const EdgeInsets.fromLTRB(5, 40, 5, 0),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          maxwidth: 300,
                          onTap: () {
                            context.read<AppBloc>().add(AppEventLogIn(
                                email: emailController.text,
                                password: passwordController.text));
                            // if (authErrorlogin.split(']')[1] ==
                                // // 'There is no user record corresponding to this identifier. The user may have been deleted.') {
                              // Navigator.push(
                                // context,
                                // PageTransition(
                                  // child: const Sign_UpScreen(),
                                  // type: PageTransitionType.fade,
                                  // duration: const Duration(milliseconds: 250),
                                // ),
                              // );
                            // }
                          },
                          buttonColor: const Color.fromARGB(255, 255, 248, 195),
                          text: 'Login',
                          textColor: const Color.fromARGB(255, 18, 40, 91),
                        ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
