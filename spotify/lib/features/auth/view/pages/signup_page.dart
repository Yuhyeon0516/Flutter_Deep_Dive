import 'package:flutter/material.dart';
import 'package:spotify/core/theme/app_pallete.dart';
import 'package:spotify/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify/features/auth/view/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              const AuthGradientButton(),
              const SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: const [
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
