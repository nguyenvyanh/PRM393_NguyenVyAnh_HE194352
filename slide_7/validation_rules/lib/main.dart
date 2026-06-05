import 'package:flutter/material.dart';

void main() => runApp(const Lab72App());

class Lab72App extends StatelessWidget {
  const Lab72App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7.2 – Validation Rules',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const ValidationSignupScreen(),
    );
  }
}

class ValidationSignupScreen extends StatefulWidget {
  const ValidationSignupScreen({super.key});

  @override
  State<ValidationSignupScreen> createState() => _ValidationSignupScreenState();
}

class _ValidationSignupScreenState extends State<ValidationSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 7.2 – Validation Rules")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => _email = v.trim(),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (v) => _password = v,
                validator: _validatePassword,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
                onChanged: (v) => _confirmPassword = v,
                validator: _validateConfirmPassword,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Create account"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // VALIDATION FUNCTIONS
  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return "Email is required";
    if (!text.contains("@") || !text.contains(".")) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return "Password is required";
    if (text.length < 8) return "Use at least 8 characters";
    if (!text.contains(RegExp(r"[0-9]"))) return "Include a number";
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return "Please confirm password";
    if (value != _password) return "Passwords do not match";
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account created for $_email")),
    );
  }
}
