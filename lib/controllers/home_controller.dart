import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth.dart';
import '../bloc/app_bloc.dart';
import '../screens/home_screen.dart';
import '../screens/welcome_screen.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        return BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppStateLoggedIn) {
              return const HomeScreen();
            }
            if (state is AppStateLoggedOut) {
              return const WelcomeScreen();
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
