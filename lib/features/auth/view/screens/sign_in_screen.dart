import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/core/helpers/show_custom_snackbar.dart';
import 'package:lanars_test_task/core/navigation/app_router.gr.dart';
import 'package:lanars_test_task/features/auth/viewModel/bloc/auth_bloc.dart';

import '../../../../core/common/user/user_cubit.dart';
import '../../../../core/helpers/validator.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is AuthError) {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar(context: context, message: state.error);
          }
          if (state is AuthLoaded) {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar(
                context: context,
                message: 'Log in successful!',
                showCloseIcon: true);
            context.read<UserCubit>().loadUser();
            context.router.push(HomeRoute());
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 72),
                  _SignInForm(isLoading: isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  final bool isLoading;
  const _SignInForm({required this.isLoading});

  @override
  State<_SignInForm> createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        setState(() {
          emailError = Validator.validateUserEmail(emailController.text);
        });
      }
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        setState(() {
          passwordError = Validator.validatePassword(passwordController.text);
        });
      }
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            focusNode: emailFocusNode,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              labelText: 'Email',
              errorText: emailError,
            ),
            enabled: !widget.isLoading,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              if (emailError != null) {
                setState(() {
                  emailError = null;
                });
              }
            },
            validator: (value) => Validator.validateUserEmail(value),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              labelText: 'Password',
              errorText: passwordError,
            ),
            enabled: !widget.isLoading,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              if (passwordError != null) {
                setState(() {
                  passwordError = null;
                });
              }
            },
            validator: (value) => Validator.validatePassword(value),
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 44),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      authBloc.add(
                        AuthSignIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          formKey: formKey,
                        ),
                      );
                    },
              child: widget.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text('Log In'),
            ),
          ),
        ],
      ),
    );
  }
}
