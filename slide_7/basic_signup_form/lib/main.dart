import 'package:flutter/material.dart';

void main() => runApp(const Lab7_1App());

class Lab7_1App extends StatelessWidget {
  const Lab7_1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7.1 – Basic Form',
      theme: ThemeData.dark(useMaterial3: true),
      home: const BasicSignupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BasicSignupScreen extends StatefulWidget {
  const BasicSignupScreen({super.key});

  @override
  State<BasicSignupScreen> createState() => _BasicSignupScreenState();
}

class _BasicSignupScreenState extends State<BasicSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Signup Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Email is required';
                  if (!text.contains('@') || !text.contains('.')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Use at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    _formKey.currentState!.save();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed up as $_name ($_email)'),
      ),
    );
  }
}

