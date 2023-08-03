import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

final Auth = 0.obs;

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bienvenido",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: Auth.value == 0
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Crear una cuenta",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: 0,
                  groupValue: Auth.value,
                  onChanged: (value) {
                    Auth.value = value!;
                  },
                ),
              ),
              if (Auth.value == 0)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _nameController, hintText: "Name"),
                        const Gap(10),
                        CustomTextField(
                            controller: _emailController, hintText: "Email"),
                        const Gap(10),
                        CustomTextField(
                            controller: _passwordController,
                            hintText: "Password"),
                        const Gap(10),
                        CustomButton(
                          text: "Crear Cuenta",
                          onPressed: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: Auth.value == 1
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Ingresar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: 1,
                  groupValue: Auth.value,
                  onChanged: (value) {
                    Auth.value = value!;
                  },
                ),
              ),
              if (Auth.value == 1)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _emailController, hintText: "Email"),
                        const Gap(10),
                        CustomTextField(
                            controller: _passwordController,
                            hintText: "Contraseña"),
                        const Gap(10),
                        CustomButton(
                          text: "Ingresar",
                          onPressed: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
