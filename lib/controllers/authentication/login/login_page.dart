import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: _SignInForm(),
        ));
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: _key,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name player',
                  filled: true,
                  isDense: true,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (value == null) {
                    return 'name is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  isDense: true,
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null) {
                    return 'Password is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text('LOG IN'),
                onPressed: _controller.state is LoginLoading
                    ? () {}
                    : _onLoginButtonPressed,
              ),
              const SizedBox(
                height: 20,
              ),
              if (_controller.state is LoginFailure)
                Text(
                  (_controller.state as LoginFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is LoginLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      );
    });
  }

  _onLoginButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
