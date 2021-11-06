import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String? username;

  final rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final focusedStyle = const TextStyle(color: Colors.green);
  final unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(username ?? '🍔 username'),
              const SizedBox(height: 16),
              _buildTextField('🎹 password'),
              const SizedBox(height: 16),
              _buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return TextField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: rwColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () async {},
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
