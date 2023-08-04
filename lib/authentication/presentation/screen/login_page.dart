import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_event.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_state.dart';
import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/finances_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';

import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String error = "";

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/login_bg.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 316,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Small divider to scroll the container up
                          Container(
                            height: 3,
                            width: 75,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(22),
                              ),
                            ),
                          ),
                          // Title "Connectez vous à votre compte"
                          const Text(
                            "Connectez vous à votre compte",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: "inter"),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          // Username input field
                          _buildInputField(
                            label: "Nom d'utilisateur",
                            hint: "Entrez votre nom d'utilisateur",
                          ),
                          const SizedBox(height: 16),
                          // Password input field with toggle icon
                          _buildInputField(
                            label: "Mot de passe",
                            hint: "Entrez votre mot de passe",
                            obscureText: !_isPasswordVisible,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          BlocListener<UserBloc, UserBlocState>(
                            listener: (context, state) {
                              if (state is ErrorUserBlocState) {
                                setState(() {
                                  error = state.message;
                                });
                              } else if (state is AdministratorLoginState) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PageAdminBaseScreen()),
                                    (Route<dynamic> route) => false);
                              } else if (state is PageAdminLoginState) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PageAdminBaseScreen()),
                                    (Route<dynamic> route) => false);
                              } else if (state is FinancesLoginState) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FinancesBaseScreen()),
                                    (Route<dynamic> route) => false);
                              } else if (state is LogistiquesLoginState) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LogistiquesBaseScreen()),
                                    (Route<dynamic> route) => false);
                              }
                            },
                            child: Container(),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: InkWell(
                              onTap: () {
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                final userCred = User(
                                  username: username,
                                  password: password,
                                );
                                //
                                BlocProvider.of<UserBloc>(context).add(
                                  LoginuserEvent(
                                    user: userCred,
                                  ),
                                );
                                // Navigator.of(context, rootNavigator: true).push(
                                //   MaterialPageRoute(
                                //     builder: (_) => const BaseScreen(),
                                //   ),
                                // );
                              },
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Se connecter",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9F9F9F),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: TextField(
            obscureText: obscureText,
            controller: obscureText ? _passwordController : _usernameController,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
