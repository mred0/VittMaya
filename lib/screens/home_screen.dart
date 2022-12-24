import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vittamaya/bloc/app_bloc.dart';

import '../widgets/common_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/bubble-up-down_animation.json',
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.cover,
                  reverse: true),
              Align(
                alignment: Alignment.bottomCenter,
                child: CommonButtonWidget(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  maxwidth: 300,
                  onTap: () {
                    context.read<AppBloc>().add(const AppEventLogOut());
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  buttonColor: const Color(0xffCA8A8B),
                  text: 'LogOut',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
