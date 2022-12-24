import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vittamaya/controllers/email_and_password_controller.dart';

import '../bloc/app_bloc.dart';
import '../widgets/common_button_widget.dart';
import '../widgets/text_formfeild_widget.dart';

class Sign_UpScreen extends StatefulWidget {
  const Sign_UpScreen({Key? key}) : super(key: key);

  @override
  State<Sign_UpScreen> createState() => Sign_UpScreenState();
}

class Sign_UpScreenState extends State<Sign_UpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffE6C4C0),
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            // height: MediaQuery.of(context).size.height * 0.2,
            // ),
            Lottie.asset(
              'assets/data-inform_animation.json',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: AppTextField(
                controller: emailController,
                onFieldSubmitted: (value) {
                  context.read<AppBloc>().emit(
                      AppStateLoggedOut(isLoading: false, successful: false));
                },
                fillcolor: const Color(0xffCFFDF1),
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: AppTextField(
                controller: passwordController,
                fillcolor: const Color(0xffCFFDF1),
                hintText: 'Enter Password',
                hintColor: Colors.black26,
                bordercolor: Colors.transparent,
                enabled: true,
                removeBorder: true,
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return Container(
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : CommonButtonWidget(
                          buttonPadding: const EdgeInsets.fromLTRB(5, 40, 5, 0),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          maxwidth: 300,
                          onTap: () {
                            context.read<AppBloc>().add(AppEventRegister(
                                email: emailController.text,
                                password: passwordController.text));
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          buttonColor: const Color(0xffCA8A8B),
                          text: 'Sign_Up',
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
